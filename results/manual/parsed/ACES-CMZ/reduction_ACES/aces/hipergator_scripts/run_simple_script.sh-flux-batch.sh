#!/bin/bash
#FLUX: --job-name=doopy-underoos-3574
#FLUX: --urgency=16

export LOGFILENAME='${LOG_DIR}/casa_log_${jobname}_${SLURM_JOB_ID}_$(date +%Y-%m-%d_%H_%M_%S).log'
export ACES_ROOTDIR='/orange/adamginsburg/ACES/reduction_ACES/'
export CASAPATH='/orange/adamginsburg/casa/${CASAVERSION}'
export MPICASA='${CASAPATH}/bin/mpicasa'
export CASA='${CASAPATH}/bin/casa'
export casapython='${CASAPATH}/lib/py/bin/python3'
export OMPI_COMM_WORLD_SIZE='$SLURM_NTASKS'
export INTERACTIVE='0'
export LD_LIBRARY_PATH='${CASAPATH}/lib/:$LD_LIBRARY_PATH'
export OPAL_PREFIX='${CASAPATH}/lib/mpi'
export IPYTHONDIR='$SLURM_TMPDIR'
export IPYTHON_DIR='$IPYTHONDIR'

set -o xtrace
env
pwd; hostname; date
echo "Memory=${MEM}"
echo "job name = $jobname"
if [ -z $jobname ]; then
    export jobname=$SLURM_JOB_NAME
    echo "job name = $jobname (set from SLURM_JOB_NAME=${SLURM_JOB_NAME}"
fi
module load intel/2020.0.166 openmpi/4.1.1 libfuse/3.10.4
LOG_DIR=/blue/adamginsburg/adamginsburg/ACES/logs
export LOGFILENAME="${LOG_DIR}/casa_log_${jobname}_${SLURM_JOB_ID}_$(date +%Y-%m-%d_%H_%M_%S).log"
WORK_DIR='/blue/adamginsburg/adamginsburg/ACES/workdir/'
cd ${WORK_DIR}
export ACES_ROOTDIR="/orange/adamginsburg/ACES/reduction_ACES/"
CASAVERSION=casa-6.4.3-2-pipeline-2021.3.0.17
CASAVERSION=casa-6.4.1-12-pipeline-2022.2.0.68
CASAVERSION=casa-6.5.5-21-py3.8
CASAVERSion=casa-6.5.7-1-py3.8.el7
export CASAPATH=/orange/adamginsburg/casa/${CASAVERSION}
export MPICASA=${CASAPATH}/bin/mpicasa
export CASA=${CASAPATH}/bin/casa
export casapython=${CASAPATH}/lib/py/bin/python3
export OMPI_COMM_WORLD_SIZE=$SLURM_NTASKS
if [ -z $OMP_NUM_THREADS ]; then
    export OMP_NUM_THREADS=1
fi
export INTERACTIVE=0
export LD_LIBRARY_PATH=${CASAPATH}/lib/:$LD_LIBRARY_PATH
export OPAL_PREFIX="${CASAPATH}/lib/mpi"
export IPYTHONDIR=$SLURM_TMPDIR
export IPYTHON_DIR=$IPYTHONDIR
cp ~/.casa/config.py $SLURM_TMPDIR
if [ -z $SLURM_NTASKS ]; then
    echo "FAILURE: SLURM_NTASKS was not specified"
    exit 1
fi
mpi_ntasks=$(python -c "print(int(${SLURM_NTASKS} / 2 + 1))")
echo ""
echo "env just before running the command:"
env
echo "mpi_ntasks=${mpi_ntasks}"
pwd
if [ ${mpi_ntasks} -gt 1 ]; then
    echo ${MPICASA} -n ${mpi_ntasks} xvfb-run -d ${CASA} --logfile=${LOGFILENAME} --nogui --nologger --rcdir=$SLURM_TMPDIR -c "execfile('$SCRIPTNAME')"
    ${MPICASA} -n ${mpi_ntasks} xvfb-run -d ${CASA} --logfile=${LOGFILENAME} --nogui --nologger --rcdir=$SLURM_TMPDIR -c "execfile('$SCRIPTNAME')" || exit 1
else
    echo xvfb-run -d ${CASA} --logfile=${LOGFILENAME} --nogui --nologger --rcdir=$SLURM_TMPDIR -c "execfile('$SCRIPTNAME')"
    xvfb-run -d ${CASA} --logfile=${LOGFILENAME} --nogui --nologger --rcdir=$SLURM_TMPDIR -c "execfile('$SCRIPTNAME')" || exit 1
fi
