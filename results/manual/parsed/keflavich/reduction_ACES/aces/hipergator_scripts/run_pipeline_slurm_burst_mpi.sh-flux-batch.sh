#!/bin/bash
#FLUX: --job-name=run_pipeline_mpi
#FLUX: -n=32
#FLUX: -t=345600
#FLUX: --urgency=16

export LOGFILENAME='${LOG_DIR}/casa_log_mpi_pipeline_${SLURM_JOB_ID}_$(date +%Y-%m-%d_%H_%M_%S).log'
export ACES_ROOTDIR='/orange/adamginsburg/ACES/'
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
export RUNONCE='True'
export PLOTMSPATH='/orange/adamginsburg/casa/${CASAVERSION}/hacked-plotms/squashfs-root/AppRun'

env
pwd; hostname; date
echo "Memory=${MEM}"
module load intel/2020.0.166 openmpi/4.1.1 libfuse/3.10.4
LOG_DIR=/blue/adamginsburg/adamginsburg/ACES/logs
export LOGFILENAME="${LOG_DIR}/casa_log_mpi_pipeline_${SLURM_JOB_ID}_$(date +%Y-%m-%d_%H_%M_%S).log"
WORK_DIR='/orange/adamginsburg/ACES/rawdata/2021.1.00172.L'
cd ${WORK_DIR}
export ACES_ROOTDIR="/orange/adamginsburg/ACES/"
CASAVERSION=casa-6.2.1-7-pipeline-2021.2.0.128
CASAVERSION=casa-6.4.3-2-pipeline-2021.3.0.17
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
export IPYTHONDIR=$SLURM_TMPDIR
export IPYTHON_DIR=$IPYTHONDIR
cp ~/.casa/config.py $SLURM_TMPDIR
if [ -z $SLURM_NTASKS ]; then
    echo "FAILURE: SLURM_NTASKS was not specified"
    exit 1
fi
export RUNONCE=True
mkdir /orange/adamginsburg/casa/${CASAVERSION}/hacked-plotms
cd /orange/adamginsburg/casa/${CASAVERSION}/hacked-plotms
/orange/adamginsburg/casa/${CASAVERSION}/lib/py/lib/python3.*/site-packages/casaplotms/__bin__/casaplotms-x86_64.AppImage --appimage-extract
ln -sf $SLURM_TMPDIR/casaplotms/squashfs-root/AppRun /home/adamginsburg/bin/plotmsAppRun
export PLOTMSPATH=/orange/adamginsburg/casa/${CASAVERSION}/hacked-plotms/squashfs-root/AppRun
cd -
echo "Hacking plotms"
echo "plotms = /orange/adamginsburg/casa/${CASAVERSION}/lib/py/lib/python3.6/site-packages/casaplotms/private/plotmstool.py"
python3 ${ACES_ROOTDIR}/reduction_ACES/aces/hipergator_scripts/hack_plotms.py  /orange/adamginsburg/casa/${CASAVERSION}/lib/py/lib/python3.6/site-packages/casaplotms/private/plotmstool.py
hacksuccess=$?
if [ $hacksuccess -eq 99 ]; then
    echo "plotms file was corrupted"
    exit $hacksuccess
fi
echo "Hacked plotms"
echo "CASA version is $CASAVERSION"
RUNSCRIPTS=False /orange/adamginsburg/casa/${CASAVERSION}/bin/python3 ${ACES_ROOTDIR}/reduction_ACES/aces/retrieval_scripts/run_pipeline.py > $SLURM_TMPDIR/scriptlist
echo "Script List"
cat $SLURM_TMPDIR/scriptlist
echo "***********"
for script in $(cat $SLURM_TMPDIR/scriptlist); do 
    IFS='/' read -r -a array <<< "$script"
    mous=${array[2]}
    echo "MOUS is ${mous}, script is ${script}"
    if [ -z $mous ]; then
        echo "MOUS '${mous}' was unspecified, which is a bug."
        echo "script was '${script}'"
        echo "Scriptlist was :"
        cat $SLURM_TMPDIR/scriptlist
        echo "pwd=$(pwd)"
        echo "previous cwd=${cwd}"
        exit 1
    fi
    if [[ $script == *imaging* ]]; then
        imaging="imaging_"
    else
        imaging=""
    fi
    export LOGFILENAME="${LOG_DIR}/casa_log_mpi_pipeline_${imaging}${mous}_${SLURM_JOB_ID}_$(date +%Y-%m-%d_%H_%M_%S).log"
    cwd=$(pwd)
    cd $(dirname $script)
    pwd
    echo "script: " $script
    echo
    #echo srun --export=ALL --mpi=pmix_v3 ${CASA} --logfile=${LOGFILENAME} --pipeline --nogui --nologger --rcdir=$SLURM_TMPDIR -c "execfile('${script}')"
    #srun --export=ALL --mpi=pmix_v3 
    echo xvfb-run -d ${MPICASA} -n $SLURM_NTASKS ${CASA} --logfile=${LOGFILENAME} --pipeline --nogui --nologger --rcdir=$SLURM_TMPDIR -c "execfile('$(basename ${script})')"
    xvfb-run -d ${MPICASA} -n $SLURM_NTASKS ${CASA} --logfile=${LOGFILENAME} --pipeline --nogui --nologger --rcdir=$SLURM_TMPDIR -c "execfile('$(basename ${script})')" || exit 1
    echo "Completed MPICASA run"
    cd $cwd
done
echo "Done"
