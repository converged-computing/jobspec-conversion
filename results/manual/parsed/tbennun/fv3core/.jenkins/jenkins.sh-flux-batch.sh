#!/bin/bash
#FLUX: --job-name=boopy-ricecake-5929
#FLUX: --urgency=16

export python_env='${python_env}'
export jenkins_dir='`dirname $0`'
export DATA_VERSION='`grep "FORTRAN_SERIALIZED_DATA_VERSION=" Makefile  | cut -d '=' -f 2`'
export TEST_DATA_DIR='${SCRATCH}/jenkins/scratch/fv3core_fortran_data/${DATA_VERSION}'
export FV3_STENCIL_REBUILD_FLAG='False'
export TEST_DATA_HOST='${TEST_DATA_DIR}/${experiment}/'
export EXPERIMENT='${experiment}'
export JENKINS_TAG='${JENKINS_TAG//[,=\/]/-}'
export DOCKER_BUILDKIT='1'

exitError()
{
    echo "ERROR $1: $3" 1>&2
    echo "ERROR     LOCATION=$0" 1>&2
    echo "ERROR     LINE=$2" 1>&2
    exit $1
}
echo "####### executing: $0 $* (PID=$$ HOST=$HOSTNAME TIME=`date '+%D %H:%M:%S'`)"
T="$(date +%s)"
test -n "$1" || exitError 1001 ${LINENO} "must pass an argument"
test -n "${slave}" || exitError 1005 ${LINENO} "slave is not defined"
input_backend="$2"
if [[ $input_backend = gtc_gt_* ]] ; then
    # sed explained: replace _ with :, two times
    input_backend=`echo $input_backend | sed 's/_/:/;s/_/:/'`
fi
if [[ $input_backend = gtc_* ]] ; then
    # sed explained: replace _ with :
    input_backend=`echo $input_backend | sed 's/_/:/'`
fi
action="$1"
backend="$input_backend"
experiment="$3"
pushd `dirname $0` > /dev/null
envloc=`/bin/pwd`
popd > /dev/null
shopt -s expand_aliases
. ${envloc}/env.sh
test -f ${envloc}/env/machineEnvironment.sh || exitError 1201 ${LINENO} "cannot find machineEnvironment.sh script"
. ${envloc}/env/machineEnvironment.sh
export python_env=${python_env}
echo "PYTHON env ${python_env}"
export jenkins_dir=`dirname $0`
if [ -z "${GT4PY_VERSION}" ]; then
    export GT4PY_VERSION=`cat GT4PY_VERSION.txt`
fi
if [[ $backend != *numpy* ]];then
    . ${jenkins_dir}/actions/fetch_caches.sh $backend $experiment
fi
if [ ! -f ${envloc}/env/env.${host}.sh ] ; then
    exitError 1202 ${LINENO} "could not find ${envloc}/env/env.${host}.sh"
fi
. ${envloc}/env/env.${host}.sh
script="${jenkins_dir}/actions/${action}.sh"
test -f "${script}" || exitError 1301 ${LINENO} "cannot find script ${script}"
. ${envloc}/env/schedulerTools.sh
scheduler_script="`dirname $0`/env/submit.${host}.${scheduler}"
if [ -f ${scheduler_script} ] ; then
    if [ "${action}" == "setup" ]; then
	scheduler="none"
    else
	cp  ${scheduler_script} job_${action}.sh
	scheduler_script=job_${action}.sh
    fi
fi
if [ -v LONG_EXECUTION ]; then
    sed -i 's|00:45:00|03:30:00|g' ${scheduler_script}
fi
if grep -q "parallel" <<< "${script}"; then
    if grep -q "ranks" <<< "${experiment}"; then
	export NUM_RANKS=`echo ${experiment} | grep -o -E '[0-9]+ranks' | grep -o -E '[0-9]+'`
	echo "Setting NUM_RANKS=${NUM_RANKS}"
	if grep -q "cuda\|gpu" <<< "${backend}" ; then
	    export MPICH_RDMA_ENABLED_CUDA=1
        export CRAY_CUDA_MPS=1
	else
	    export MPICH_RDMA_ENABLED_CUDA=0
        export CRAY_CUDA_MPS=0
	fi
	if [ -f ${scheduler_script} ] ; then
	    sed -i 's|<NTASKS>|<NTASKS>\n#SBATCH \-\-hint=multithread\n#SBATCH --ntasks-per-core=2|g' ${scheduler_script}
	    sed -i 's|45|30|g' ${scheduler_script}
	    if [ "$NUM_RANKS" -gt "6" ] && [ ! -v LONG_EXECUTION ]; then
            sed -i 's|cscsci|debug|g' ${scheduler_script}
        elif [ "$NUM_RANKS" -gt "6" ]; then
            sed -i 's|cscsci|normal|g' ${scheduler_script}
        fi
	    sed -i 's|<NTASKS>|"'${NUM_RANKS}'"|g' ${scheduler_script}
	    sed -i 's|<NTASKSPERNODE>|"24"|g' ${scheduler_script}
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
    sed -i 's|00:45:00|03:30:00|g' ${scheduler_script}
    sed -i 's|<NTASKSPERNODE>|6|g' ${scheduler_script}
    sed -i 's/<CPUSPERTASK>/1/g' ${scheduler_script}
    export MPIRUN_CALL="srun"
fi
module load daint-gpu
module load ${installdir}/modulefiles/gcloud/303.0.0
export DATA_VERSION=`grep "FORTRAN_SERIALIZED_DATA_VERSION=" Makefile  | cut -d '=' -f 2`
if [ -z ${SCRATCH} ] ; then
    export SCRATCH=`pwd`
fi
export TEST_DATA_DIR="/project/s1053/fv3core_serialized_test_data/${DATA_VERSION}"
export TEST_DATA_DIR="${SCRATCH}/jenkins/scratch/fv3core_fortran_data/${DATA_VERSION}"
export FV3_STENCIL_REBUILD_FLAG=False
export TEST_DATA_HOST="${TEST_DATA_DIR}/${experiment}/"
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
    export VIRTUALENV=${envloc}/../venv_${JENKINS_TAG}
fi
if [ ${python_env} == "virtualenv" ]; then
    if [ -d ${VIRTUALENV} ]; then
	echo "Using existing virtualenv ${VIRTUALENV}"
    else
	echo "virtualenv ${VIRTUALENV} is not setup yet, installing now"
	export FV3CORE_INSTALL_FLAGS="-e"
	${jenkins_dir}/install_virtualenv.sh ${VIRTUALENV}
    fi
    source ${VIRTUALENV}/bin/activate
    if grep -q "parallel" <<< "${script}"; then
	export MPIRUN_CALL="srun"
    fi
    export FV3_PATH="${envloc}/../"
    export TEST_DATA_RUN_LOC=${TEST_DATA_HOST}
    export PYTHONPATH=${installdir}/serialbox/gnu/python:$PYTHONPATH
fi
G2G="false"
export DOCKER_BUILDKIT=1
run_command "${script} ${backend} ${experiment} " Job${action} ${G2G} ${scheduler_script}
if [ $? -ne 0 ] ; then
  exitError 1510 ${LINENO} "problem while executing script ${script}"
fi
echo "### ACTION ${action} SUCCESSFUL"
. ${envloc}/env/schedulerTools.sh
run_timing_script="`dirname $0`/env/submit.${host}.${scheduler}"
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
    sed -i 's|00:45:00|00:15:00|g' ${run_timing_script}
    sed -i 's|<NTASKSPERNODE>|1|g' ${run_timing_script}
    sed -i 's/<CPUSPERTASK>/1/g' ${run_timing_script}
    sed -i 's|cscsci|debug|g' ${run_timing_script}
    run_command "${script} ${backend} ${experiment} " Job2${action} ${G2G} ${run_timing_script}
    if [ $? -ne 0 ] ; then
    exitError 1511 ${LINENO} "problem while executing script ${script}"
    fi
fi
echo "### ACTION ${action} SUCCESSFUL"
T="$(($(date +%s)-T))"
printf "####### time taken: %02d:%02d:%02d:%02d\n" "$((T/86400))" "$((T/3600%24))" "$((T/60%60))" "$((T%60))"
echo "####### finished: $0 $* (PID=$$ HOST=$HOSTNAME TIME=`date '+%D %H:%M:%S'`)"
exit 0
