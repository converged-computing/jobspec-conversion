#!/bin/bash
#SBATCH --job-name=OF10_GccOpt_icoPhase
#SBATCH --account=bddir15
#SBATCH --output=OF10_icoPhase_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=02:00:00
#SBATCH --partition=infer

export application='`getApplication`'

pwd; hostname; date
module load gcc/10.2.0; module load cmake; module load boost; module load openmpi; module load vtk; module load cuda
source $HOME/OpenFOAM/${USER}-10/etc/bashrc
unset FOAM_SIGFPE
conda activate base
source $WM_PROJECT_DIR/bin/tools/RunFunctions
export application=`getApplication`
foamDictionary system/decomposeParDict -entry numberOfSubdomains -set 16
foamDictionary system/decomposeParDict -entry hierarchicalCoeffs/n -set "( 4 4 1 )"
if [ ! -f log.decomposePar ]; then
    ./Allrun.pre
fi
runParallel $application
runApplication reconstructPar -newTimes
./Allpost
date
