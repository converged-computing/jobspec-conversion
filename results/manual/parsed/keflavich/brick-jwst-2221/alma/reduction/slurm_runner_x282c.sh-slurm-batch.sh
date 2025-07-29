#!/bin/bash
#FLUX: --job-name=cloudc00363_282c
#FLUX: -n=64
#FLUX: -t=345600
#FLUX: --urgency=16

export CASA='${CASAPATH}/bin/casa'
export CASAPATH='/orange/adamginsburg/casa/${CASAVERSION}'
export MPICASA='${CASAPATH}/bin/mpicasa'
export OMPI_COMM_WORLD_SIZE='$SLURM_NTASKS'
export INTERACTIVE='0'
export LD_LIBRARY_PATH='${CASAPATH}/lib/:$LD_LIBRARY_PATH'
export OPAL_PREFIX='${CASAPATH}/lib/mpi'
export IPYTHONDIR='$SLURM_TMPDIR'
export IPYTHON_DIR='$IPYTHONDIR'
export SCRIPT_DIR='/orange/adamginsburg/jwst/brick/alma/reduction/'
export PYTHONPATH='$SCRIPT_DIR'
export script='${SCRIPT_DIR}/first_pass_imaging_science_goal.uid___A001_X1590_X282c.py'
export LOG_DIR='/blue/adamginsburg/adamginsburg/brick_logs/'
export LOGFILENAME='${LOG_DIR}/casa_log_mpi_2021.1.00363.S_282c_${SLURM_JOB_ID}_$(date +%Y-%m-%d_%H_%M_%S).log'

pwd; hostname; date
WORK_DIR='/orange/adamginsburg/jwst/brick/alma/2021.1.00363.S/science_goal.uid___A001_X1590_X282c/group.uid___A001_X1590_X282d/member.uid___A001_X1590_X282e/calibrated/working'
module load git
which python
which git
git --version
echo $?
export CASA=/orange/adamginsburg/casa/casa-6.4.3-2-pipeline-2021.3.0.17/bin/casa
CASAVERSION=casa-6.4.3-2-pipeline-2021.3.0.17
CASAVERSION=casa-6.5.0-9-py3.8
export CASAPATH=/orange/adamginsburg/casa/${CASAVERSION}
export MPICASA=${CASAPATH}/bin/mpicasa
export CASA=${CASAPATH}/bin/casa
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
cd ${WORK_DIR}
echo ${WORK_DIR}
export SCRIPT_DIR=/orange/adamginsburg/jwst/brick/alma/reduction/
export PYTHONPATH=$SCRIPT_DIR
export script=${SCRIPT_DIR}/first_pass_imaging_science_goal.uid___A001_X1590_X282c.py
export LOG_DIR=/blue/adamginsburg/adamginsburg/brick_logs/
export LOGFILENAME="${LOG_DIR}/casa_log_mpi_2021.1.00363.S_282c_${SLURM_JOB_ID}_$(date +%Y-%m-%d_%H_%M_%S).log"
echo logfilename=$LOGFILENAME
cwd=$(pwd)
echo xvfb-run -d ${MPICASA} -n $SLURM_NTASKS ${CASA} --logfile=${LOGFILENAME} --nogui --nologger --rcdir=$SLURM_TMPDIR -c "execfile('${script}')"
xvfb-run -d ${MPICASA} -n $SLURM_NTASKS ${CASA} --logfile=${LOGFILENAME} --nogui --nologger --rcdir=$SLURM_TMPDIR -c "execfile('${script}')" || exit 1
echo "Completed MPICASA run"
