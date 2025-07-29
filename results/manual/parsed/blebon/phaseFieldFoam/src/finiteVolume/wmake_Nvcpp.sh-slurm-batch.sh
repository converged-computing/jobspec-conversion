#!/bin/bash
#SBATCH --job-name=OF10_NvcppOpt_wmake_libso_finiteVolume
#SBATCH --account=bddir15
#SBATCH --output=NvcppOpt_wmake_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=02:00:00
#SBATCH --partition=infer

export NVLOCALRC='$HOME/localrc'
export WM_NCOMPPROCS='160'

pwd; hostname; date
module load gcc/10.2.0
module load cmake
module load boost
module load vtk
module load /nobackup/projects/bddir15/hpc_sdk/modulefiles/nvhpc/23.1
makelocalrc -x -d $HOME -gcc /opt/software/builder/developers/compilers/gcc/10.2.0/1/default/bin/gcc -gpp /opt/software/builder/developers/compilers/gcc/10.2.0/1/default/bin/g++ -g77 /opt/software/builder/developers/compilers/gcc/10.2.0/1/default/bin/gfortran
export NVLOCALRC=$HOME/localrc
source ${HOME}/OpenFOAM/${USER}-10/etc/bashrc WM_COMPILE_OPTION=Opt WM_COMPILER=Nvcpp WM_MPLIB=SYSTEMOPENMPI
source $WM_PROJECT_DIR/bin/tools/RunFunctions
export WM_NCOMPPROCS=160
wmake libso
date
