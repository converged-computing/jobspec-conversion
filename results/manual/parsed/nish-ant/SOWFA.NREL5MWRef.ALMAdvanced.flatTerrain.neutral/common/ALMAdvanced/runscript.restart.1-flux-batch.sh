#!/bin/bash
#FLUX: --job-name=<rN>.1.ALA
#FLUX: -N=6
#FLUX: -t=388800
#FLUX: --urgency=16

export SLURM_COMP_VERBOSE='3'
export SLURM_LOADER_VERBOSE='3'
export OPENFAST_DIR='/home/$USER/tools/OpenFAST/install'
export HDF5_DIR='/softs/contrib/apps/hdf5/1.10.5'
export BLASLIB='/softs/contrib/apps/Openblas/0.3.6/lib -lopenblas'
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
OpenFOAMversion=OpenFOAM-6      # OpenFOAM/SOWFA version
solver=superDeliciousVanilla.turbine
interp=linearupwind             # midpoint (for gravity waves), linearupwind
runNumber=1
unset LD_LIBRARY_PATH
echo "Sourcing the bash profile, loading modules, and setting the OpenFOAM environment variables..."
source /home/nishant/.bash_profile
module purge
module load gcc/7.3.0
module load Openblas/0.3.6
module load hdf5/1.10.5/openmpi_4.0.2/gcc_7.3.0
source /home/nishant/tools/spack/share/spack/setup-env.sh
spack env activate preciceFoam 
export OPENFAST_DIR=/home/$USER/tools/OpenFAST/install
export HDF5_DIR=/softs/contrib/apps/hdf5/1.10.5
export BLASLIB="/softs/contrib/apps/Openblas/0.3.6/lib -lopenblas"
export SOWFA_DIR=$WM_PROJECT_USER_DIR/SOWFA6
export SOWFA_APPBIN=$SOWFA_DIR/platforms/$WM_OPTIONS/bin
export SOWFA_LIBBIN=$SOWFA_DIR/platforms/$WM_OPTIONS/lib
export LD_LIBRARY_PATH=$SOWFA_LIBBIN:$OPENFAST_DIR/lib:$BLASLIB:$LD_LIBRARY_PATH
export PATH=$SOWFA_APPBIN:$OPENFAST_DIR/bin:$PATH
pythonPATH=/home/nishant/tools/spack/var/spack/environments/preciceFoam/.spack-env/view/bin/python
if [ ! -f log.preprocess ];                        then echo "Job killed (1)"; scancel $SLURM_JOBID; fi
if [ ! -f system/controlDict.$runNumber ];         then echo "Job killed (2)"; scancel $SLURM_JOBID; fi
if [ ! -f setUp ];                                 then echo "Job killed (3)"; scancel $SLURM_JOBID; fi
cp system/controlDict.$runNumber                       system/controlDict
cp system/fvSchemes.flow.$interp                       system/fvSchemes
cores=$(foamDictionary -value -entry "nCores" setUp.WT)
parentDIR=$(pwd)
echo "Starting OpenFOAM job at: " $(date)
echo "using" $cores "core(s)"
start=`date +%s.%N`
latestTime=$(foamListTimes -processor -latestTime -withZero -noFunctionObjects| tail -1)
python updateTurbineArrayProperties.py > log.updateTurbineArrayProperties.$runNumber.startAt$latestTime 2>&1
mpirun -n $cores --bind-to core $solver -parallel > log.$solver.$runNumber.startAt$latestTime 2>&1
end=`date +%s.%N`
td=$( echo "$end - $start" | bc -l )
echo "Time elapsed:" $( date -d "@$td" -u "+$((${td%.*}/86400))-%H:%M:%S" )
