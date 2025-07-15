#!/bin/bash
#FLUX: --job-name=rainbow-car-3200
#FLUX: --urgency=16

export python_env='${python_env}'
export TEST_DATA_ROOT='${SCRATCH}/jenkins/scratch/fv3core_fortran_data/'
export FV3_STENCIL_REBUILD_FLAG='False'
export EXPERIMENT='${experiment}'
export JENKINS_TAG='${JENKINS_TAG//[,=\/]/-}'

exitError()
{
    echo "ERROR $1: $3" 1>&2
    echo "ERROR     LOCATION=$0" 1>&2
    echo "ERROR     LINE=$2" 1>&2
    exit $1
}
set -x
echo "####### executing: $0 $* (PID=$$ HOST=$HOSTNAME TIME=`date '+%D %H:%M:%S'`)"
T="$(date +%s)"
test -n "$1" || exitError 1001 ${LINENO} "must pass an argument"
test -n "${slave}" || exitError 1005 ${LINENO} "slave is not defined"
JENKINS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PACE_DIR=$JENKINS_DIR/../../
BUILDENV_DIR=$PACE_DIR/buildenv
TOP_LEVEL_JENKINS_DIR=$PACE_DIR/.jenkins
action=$1
backend=$2
experiment=$3
if [[ $backend == gt_* || $backend == dace_* ]]; then
    backend=${backend/_/:}
fi
if [ -v LONG_EXECUTION ]; then
    default_timeout=210
else
    default_timeout=45
fi
minutes=${4:-$default_timeout}
pushd `dirname $0` > /dev/null
popd > /dev/null
shopt -s expand_aliases
test -f ${BUILDENV_DIR}/machineEnvironment.sh || exitError 1201 ${LINENO} "cannot find machineEnvironment.sh script"
. ${BUILDENV_DIR}/machineEnvironment.sh
export python_env=${python_env}
echo "PYTHON env ${python_env}"
echo "Fetching existing gt_caches"
${TOP_LEVEL_JENKINS_DIR}/fetch_caches.sh $backend $experiment dycore
if [ ! -f ${BUILDENV_DIR}/env.${host}.sh ] ; then
    exitError 1202 ${LINENO} "could not find ${BUILDENV_DIR}/env.${host}.sh"
fi
. ${BUILDENV_DIR}/env.${host}.sh
script="${JENKINS_DIR}/actions/${action}.sh"
test -f "${script}" || exitError 1301 ${LINENO} "cannot find script ${script}"
. ${BUILDENV_DIR}/schedulerTools.sh
scheduler_script="${BUILDENV_DIR}/submit.${host}.${scheduler}"
if [ -f ${scheduler_script} ] ; then
    if [ "${action}" == "setup" ]; then
        scheduler="none"
    else
        cp  ${scheduler_script} job_${action}.sh
        scheduler_script=job_${action}.sh
    fi
fi
if grep -q "parallel" <<< "${script}"; then
    if grep -q "ranks" <<< "${experiment}"; then
        export NUM_RANKS=`echo ${experiment} | grep -o -E '[0-9]+ranks' | grep -o -E '[0-9]+'`
        echo "Setting NUM_RANKS=${NUM_RANKS}"
        if grep -q "cuda\|gpu" <<< "${backend}" ; then
            export MPICH_RDMA_ENABLED_CUDA=1
            # Has to be deactivated to be able to use VRAM pooling
            export CRAY_CUDA_MPS=0
        else
            export MPICH_RDMA_ENABLED_CUDA=0
            export CRAY_CUDA_MPS=0
        fi
        if [ -f ${scheduler_script} ] ; then
            sed -i 's|<NTASKS>|<NTASKS>\n#SBATCH \-\-hint=multithread|g' ${scheduler_script}
            # if [ "$NUM_RANKS" -gt "6" ] && [ ! -v LONG_EXECUTION ]; then
            #  sed -i 's|cscsci|debug|g' ${scheduler_script}
            if [[ $NUM_RANKS -gt 6 || $backend == *gpu* || $backend == *cuda* ]]; then
                sed -i 's|cscsci|normal|g' ${scheduler_script}
            fi
            sed -i "s|<NTASKS>|$NUM_RANKS|g" ${scheduler_script}
            if [[ $backend == *gpu* || $backend == *cuda* ]]; then
                ntaskspernode=1
            else
                ntaskspernode=6
            fi
            sed -i "s|<NTASKSPERNODE>|$ntaskspernode|g" ${scheduler_script}
        fi
    fi
fi
if grep -q "fv_dynamics" <<< "${script}"; then
        if grep -q "cuda\|gpu" <<< "${backend}" ; then
            export MPICH_RDMA_ENABLED_CUDA=1
            # This enables single node compilation
            # but will NOT work for c128
            export CRAY_CUDA_MPS=1
        else
            export MPICH_RDMA_ENABLED_CUDA=0
        export CRAY_CUDA_MPS=0
        fi
    sed -i 's|<NTASKS>|6\n#SBATCH \-\-hint=nomultithread|g' ${scheduler_script}
    minutes=210
    if [[ $backend == *gpu* || $backend == *cuda* ]]; then
        ntaskspernode=1
    else
        ntaskspernode=24
    fi
    sed -i "s|<NTASKSPERNODE>|$ntaskspernode|g" ${scheduler_script}
    sed -i 's|<CPUSPERTASK>|1|g' ${scheduler_script}
    export MPIRUN_CALL="srun"
fi
if [ -z ${SCRATCH} ] ; then
    export SCRATCH=`pwd`
fi
export TEST_DATA_ROOT="${SCRATCH}/jenkins/scratch/fv3core_fortran_data/"
export FV3_STENCIL_REBUILD_FLAG=False
export EXPERIMENT=${experiment}
if [ -z ${JENKINS_TAG} ]; then
    export JENKINS_TAG=${JOB_NAME}${BUILD_NUMBER}
    if [ -z ${JENKINS_TAG} ]; then
        export JENKINS_TAG=test
    fi
fi
export JENKINS_TAG=${JENKINS_TAG//[,=\/]/-}
if [ ${#JENKINS_TAG} -gt 85 ]; then
        NAME=`echo ${JENKINS_TAG} | md5sum | cut -f1 -d" "`
        export JENKINS_TAG=${NAME//[,=\/]/-}-${BUILD_NUMBER}
fi
echo "JENKINS TAG ${JENKINS_TAG}"
if [ -z ${VIRTUALENV} ]; then
    echo "setting VIRTUALENV"
    export VIRTUALENV=${JENKINS_DIR}/../venv_${JENKINS_TAG}
fi
if [ ${python_env} == "virtualenv" ]; then
    if [ -d ${VIRTUALENV} ]; then
        echo "Using existing virtualenv ${VIRTUALENV}"
    else
        echo "virtualenv ${VIRTUALENV} is not setup yet, installing now"
        export FV3CORE_INSTALL_FLAGS="-e"
        ${TOP_LEVEL_JENKINS_DIR}/install_virtualenv.sh ${VIRTUALENV}
    fi
    source ${VIRTUALENV}/bin/activate
    if grep -q "parallel" <<< "${script}"; then
        export MPIRUN_CALL="srun"
    fi
    export FV3_PATH="${JENKINS_DIR}/../"
fi
run_command "${script} ${backend} ${experiment} " Job${action} ${scheduler_script} $minutes
if [ $? -ne 0 ] ; then
  exitError 1510 ${LINENO} "problem while executing script ${script}"
fi
echo "### ACTION ${action} SUCCESSFUL"
if grep -q "fv_dynamics" <<< "${script}"; then
    cp  ${run_timing_script} job_${action}_2.sh
    run_timing_script=job_${action}_2.sh
    export CRAY_CUDA_MPS=0
        if grep -q "cuda\|gpu" <<< "${backend}" ; then
            export MPICH_RDMA_ENABLED_CUDA=1
        export CRAY_CUDA_MPS=1
        else
            export MPICH_RDMA_ENABLED_CUDA=0
        export CRAY_CUDA_MPS=0
        fi
    sed -i 's|<NTASKS>|6\n#SBATCH \-\-hint=nomultithread|g' ${run_timing_script}
    minutes=15
    sed -i 's|<NTASKSPERNODE>|1|g' ${run_timing_script}
    sed -i 's/<CPUSPERTASK>/1/g' ${run_timing_script}
    sed -i 's|cscsci|debug|g' ${run_timing_script}
    run_command "${script} ${backend} ${experiment} " Job2${action} ${run_timing_script} $minutes
    if [ $? -ne 0 ] ; then
        exitError 1511 ${LINENO} "problem while executing script ${script}"
    fi
fi
echo "### ACTION ${action} SUCCESSFUL"
T="$(($(date +%s)-T))"
printf "####### time taken: %02d:%02d:%02d:%02d\n" "$((T/86400))" "$((T/3600%24))" "$((T/60%60))" "$((T%60))"
echo "####### finished: $0 $* (PID=$$ HOST=$HOSTNAME TIME=`date '+%D %H:%M:%S'`)"
exit 0
