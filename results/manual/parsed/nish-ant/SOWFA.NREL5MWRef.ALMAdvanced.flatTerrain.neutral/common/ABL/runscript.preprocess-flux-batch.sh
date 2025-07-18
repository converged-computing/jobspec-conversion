#!/bin/bash
#FLUX: --job-name=<rN>.prep.ABL
#FLUX: -t=43200
#FLUX: --urgency=16

export SLURM_COMP_VERBOSE='3'
export SLURM_LOADER_VERBOSE='3'
export SOWFA_DIR='$WM_PROJECT_USER_DIR/SOWFA6'
export SOWFA_APPBIN='$SOWFA_DIR/platforms/$WM_OPTIONS/bin'
export SOWFA_LIBBIN='$SOWFA_DIR/platforms/$WM_OPTIONS/lib'
export LD_LIBRARY_PATH='$SOWFA_LIBBIN:$OPENFAST_DIR/lib:$BLASLIB:$LD_LIBRARY_PATH'
export PATH='$SOWFA_APPBIN:$OPENFAST_DIR/bin:$PATH'

echo "#############################"
echo "User:" $USER
echo "Submit time:" $(squeue -u $USER -o '%30j %20V' | \
    grep -e $SLURM_JOB_NAME | awk '{print $2}')
echo "Launch time:" `date +"%Y-%m-%dT%T"`
echo "Host:" `hostname`
echo "Directory:" `pwd`
echo "SLURM_JOBID:" $SLURM_JOBID
echo "SLURM_JOB_NAME:" $SLURM_JOB_NAME
echo "SLURM_SUBMIT_DIR:" $SLURM_SUBMIT_DIR
echo "SLURM_JOB_NODELIST:" $SLURM_JOB_NODELIST
echo "#############################"
umask 0077
export SLURM_COMP_VERBOSE=3
export SLURM_LOADER_VERBOSE=3
OpenFOAMversion=OpenFOAM-6      # OpenFOAM/SOWFA version. OpenFOAM-6-{gcc,intel}-{central,dev}
startTime=0                     # Start time
cores=$SLURM_NTASKS # 1
unset LD_LIBRARY_PATH
source /home/nishant/.bash_profile
module purge
module load gcc/7.3.0
source /home/nishant/tools/spack/share/spack/setup-env.sh
spack env activate preciceFoam 
export SOWFA_DIR=$WM_PROJECT_USER_DIR/SOWFA6
export SOWFA_APPBIN=$SOWFA_DIR/platforms/$WM_OPTIONS/bin
export SOWFA_LIBBIN=$SOWFA_DIR/platforms/$WM_OPTIONS/lib
export LD_LIBRARY_PATH=$SOWFA_LIBBIN:$OPENFAST_DIR/lib:$BLASLIB:$LD_LIBRARY_PATH
export PATH=$SOWFA_APPBIN:$OPENFAST_DIR/bin:$PATH
echo "Starting OpenFOAM job at: " $(date)
echo "using" $cores "core(s)"
start=`date +%s.%N`
cp system/controlDict.0 system/controlDict
rm -rf $startTime
cp -rf $startTime.original $startTime
echo "   -Building the mesh with blockMesh..."
blockMesh -noFunctionObjects > log.blockMesh 2>&1
echo "   -Renumbering the mesh with renumberMesh..."
renumberMesh -overwrite > log.renumberMesh 2>&1
echo "   -Decomposing the domain with decomposePar..."
decomposePar -cellDist -force > log.decomposePar 2>&1
echo "   -Checking the mesh with checkMesh..."
checkMesh -noFunctionObjects > log.checkMesh 2>&1
end=`date +%s.%N`
td=$( echo "$end - $start" | bc -l )
echo "Time elapsed:" $( date -d "@$td" -u "+$((${td%.*}/86400))-%H:%M:%S" )
