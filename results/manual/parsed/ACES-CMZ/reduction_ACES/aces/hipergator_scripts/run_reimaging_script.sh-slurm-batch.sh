#!/bin/bash
#FLUX: --job-name=run_reimage_mpi
#FLUX: -n=32
#FLUX: -t=345600
#FLUX: --urgency=16

export LOGFILENAME='${LOG_DIR}/casa_log_mpi_reimaging_${SLURM_JOB_ID}_$(date +%Y-%m-%d_%H_%M_%S).log'
export ACES_ROOTDIR='/orange/adamginsburg/ACES/reduction_ACES/'
export CASAPATH='/orange/adamginsburg/casa/${CASAVERSION}'
export MPICASA='${CASAPATH}/bin/mpicasa'
export CASA='${CASAPATH}/bin/casa'
export casapython='${CASAPATH}/lib/py/bin/python3'
export OMPI_COMM_WORLD_SIZE='$SLURM_NTASKS'
export INTERACTIVE='0'
export LD_LIBRARY_PATH='${CASAPATH}/lib/:$LD_LIBRARY_PATH'
export OPAL_PREFIX='${CASAPATH}/lib/mpi'
export APPIMAGE_EXTRACT_AND_RUN='1'
export ACES_DATADIR='/orange/adamginsburg/ACES/rawdata/'
export TRYDROPTARGET='True'
export SCRIPTLIST='reimaging_script_list.txt' # written in write_tclean_scripts.py'

echo "Use job_runner instead"
exit
pwd; hostname; date
echo "Memory=${MEM}"
module load intel/2020.0.166
module load openmpi/4.1.1
LOG_DIR=/blue/adamginsburg/adamginsburg/ACES/logs
export LOGFILENAME="${LOG_DIR}/casa_log_mpi_reimaging_${SLURM_JOB_ID}_$(date +%Y-%m-%d_%H_%M_%S).log"
WORK_DIR='/orange/adamginsburg/ACES/rawdata/2021.1.00172.L'
export ACES_ROOTDIR="/orange/adamginsburg/ACES/reduction_ACES/"
CASAVERSION=casa-6.2.1-7-pipeline-2021.2.0.128
CASAVERSION=casa-6.4.3-2-pipeline-2021.3.0.17
CASAVERSION=casa-6.4.4-31-py3.8
CASAVERSION=casa-6.4.1-12-pipeline-2022.2.0.68
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
cp ~/.casa/config.py ${TMPDIR}
export APPIMAGE_EXTRACT_AND_RUN=1
if [ -z $SLURM_NTASKS ]; then
    echo "FAILURE: SLURM_NTASKS was not specified"
    exit 1
fi
export ACES_DATADIR=/orange/adamginsburg/ACES/rawdata/
export TRYDROPTARGET=True
export SCRIPTLIST='reimaging_script_list.txt' # written in write_tclean_scripts.py
REIMAGING=/orange/adamginsburg/ACES/reduction_ACES/imaging/write_tclean_scripts.py
env
DUMMYRUN=True RUNONCE=False ${MPICASA} -n $SLURM_NTASKS xvfb-run -d ${CASA} --logfile=${LOGFILENAME} --nogui --nologger --rcdir=${TMPDIR} -c "execfile('${REIMAGING}')"
echo "Completed dummy run"
cat $SCRIPTLIST
firstscript=$(head -n 1 $SCRIPTLIST)
if [ -z $firstscript ]; then
    echo "FAILURE: no $firstscript"
    exit 1
fi
echo "Running the following tclean command: $firstscript"
cat $firstscript
echo
echo
cd /blue/adamginsburg/adamginsburg/ACES/workdir 
jn=$(basename $firstscript)
jn=${jn/.py/}
jn=${jn/tclean_cube_pars_Sgr_A_st_/}
echo ${MPICASA} -n $SLURM_NTASKS xvfb-run -d ${CASA} --logfile=${LOGFILENAME} --nogui --nologger --rcdir=${TMPDIR} -c "execfile('$firstscript')"
${MPICASA} -n $SLURM_NTASKS xvfb-run -d ${CASA} --logfile=${LOGFILENAME} --nogui --nologger --rcdir=${TMPDIR} -c "execfile('$firstscript')"
