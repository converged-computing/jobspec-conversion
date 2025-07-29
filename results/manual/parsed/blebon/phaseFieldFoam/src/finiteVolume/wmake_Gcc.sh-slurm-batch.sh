#!/bin/bash
#SBATCH --job-name=OF10_GccOpt_wmake_libso_finiteVolume
#SBATCH --account=bddir15
#SBATCH --output=GccOpt_wmake_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=02:00:00
#SBATCH --partition=infer

export WM_NCOMPPROCS='160'

pwd; hostname; date
module load gcc/10.2.0
module load cmake
module load boost
module load vtk
module load nvhpc
module load cuda
source ${HOME}/OpenFOAM/${USER}-10/etc/bashrc WM_COMPILE_OPTION=Opt
source $WM_PROJECT_DIR/bin/tools/RunFunctions
export WM_NCOMPPROCS=160
wmake libso
date
