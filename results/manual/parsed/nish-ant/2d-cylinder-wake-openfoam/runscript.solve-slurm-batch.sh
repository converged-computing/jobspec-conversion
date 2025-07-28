#!/bin/bash
#FLUX: --job-name=laminarVortexShedding
#FLUX: --queue=imb-resources
#FLUX: -t=43200
#FLUX: --urgency=16

export SLURM_COMP_VERBOSE='3'
export SLURM_LOADER_VERBOSE='3'
export MODULEPATH='$HOME/centos_7/easybuild/modules/all/Core:$MODULEPATH'

echo "#############################"
echo "User:" $USER
echo "Date:" `date`
echo "Host:" `hostname`
echo "Directory:" `pwd`
echo "SLURM_JOBID:" $SLURM_JOBID
echo "SLURM_SUBMIT_DIR:" $SLURM_SUBMIT_DIR
echo "SLURM_JOB_NODELIST:" $SLURM_JOB_NODELIST
echo "SLURM_TASKS_PER_NODE:" $SLURM_TASKS_PER_NODE
echo "#############################"
umask 0077
export SLURM_COMP_VERBOSE=3
export SLURM_LOADER_VERBOSE=3
np=12
ms="m0.5"
moveToScratch=0
moveFromScratch=0
cronEraseFlag=0
lastTimeErase='none'
source /gpfs/home/nkumar001/.bash_profile
module purge
export MODULEPATH=$HOME/centos_7/easybuild/modules/all/Core:$MODULEPATH
module load GCC/5.4.0-2.26 OpenMPI/1.10.3 OpenFOAM/2.4.0
source ${EBROOTOPENFOAM}/OpenFOAM-${EBVERSIONOPENFOAM}/etc/bashrc
dt=$(date '+%Y%m%d') # %H:%M:%S
if [ $moveToScratch -eq 1 ]; then
    #- Place the job in the scratch directory
    SCRDIR=/scratch/$USER/$(realpath ${SLURM_SUBMIT_DIR} | cut -d'/' -f5-).$ms.run${dt}
    mkdir -p $SCRDIR
    # 
    #- Copy the input files to ${TMP}
    echo "Copying from ${SLURM_SUBMIT_DIR}/ to ${SCRDIR}/"
    /usr/bin/rsync -arvx "${SLURM_SUBMIT_DIR}/" ${SCRDIR}/
    #
    cd $SCRDIR
fi
parentDIR=$(pwd)
timeEraseFile=$parentDIR/postProcessing/internalField/listDif.tmp
if [ "$lastTimeErase" == "auto" -a -f "$timeEraseFile" ]; then
    lastTimeErase=$(tac $timeEraseFile |egrep -m 1 .)
fi
endFlag=0
stage="runTime"
eraseCmd="$parentDIR/system/sampling/eraseCoordinatesAuto.sh \
    $parentDIR $endFlag $lastTimeErase $cronEraseFlag \
    > $parentDIR/log.eraseCoordinates.$stage 2>&1"
if [ $cronEraseFlag -eq 1 ]; then
    cronJob="*/1 * * * * $eraseCmd"
    ( crontab -l | grep -v -F "$eraseCmd" ; echo "$cronJob" ) | crontab -
fi
echo "Starting OpenFOAM job at: " $(date) " using " $nprocs " cores"
start=`date +%s.%N`
cp ${parentDIR}/system/sampling/pointCloud.${ms}.dat ${parentDIR}/system/sampling/pointCloud.dat
boundaryFile="constant/polyMesh/boundary"
if [ -f "$boundaryFile" ]; then
    mv $boundaryFile ${boundaryFile}.bak
else
    echo ERROR: Failed to find ${boundaryFile}. Run gmshToFoam.
    exit 1
fi
gmshToFoam cylinder.${ms}.msh > log.gmshToFoam 2>&1
if [ -f $boundaryFile.bak ]; then
    mv ${boundaryFile}.bak $boundaryFile
fi
checkMesh > log.checkMesh.1 2>&1
renumberMesh -overwrite > log.renumberMesh 2>&1
decomposePar > log.decomposePar 2>&1
checkMesh > log.checkMesh.2 2>&1
mpirun -np $np icoFoam -parallel < /dev/null > log.icoFoam 2>&1
end=`date +%s.%N`
echo "Ending OpenFOAM job at: " $(date)
echo "Runtime:" $( echo "$end - $start" | bc -l )
if [ $cronEraseFlag -eq 0 ]; then
    start=`date +%s.%N`
    $eraseCmd
    end=`date +%s.%N`
    echo "Time elapsed for erasing coordinates:" $( echo "$end - $start" | bc -l )
fi
if [ $cronEraseFlag -eq 1 ]; then
    endFlag=1
    stage="endTime"
    $eraseCmd
    #- Remove crontab entries
    # /usr/bin/crontab -r
    ( crontab -l | grep -v -F "$eraseCmd" ) | crontab -
fi
if [ $moveFromScratch -eq 1 ]; then
    #- Job done, copy everything back
    echo "Copying from ${SCRDIR}/ to ${SLURM_SUBMIT_DIR}/"
    /usr/bin/rsync -avx --exclude "*_0.gz" --exclude "phi*.gz" --exclude "ddt*.gz" ${SCRDIR}/ "${SLURM_SUBMIT_DIR}/"
    #- Delete temporary files
    [ $? -eq 0 ] && /bin/rm -rf ${SCRDIR}
fi
