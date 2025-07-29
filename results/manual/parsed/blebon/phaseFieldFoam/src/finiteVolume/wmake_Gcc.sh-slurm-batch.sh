#!/bin/bash
#FLUX: --job-name=OF10_GccOpt_wmake_libso_finiteVolume
#FLUX: --queue=infer
#FLUX: -t=7200
#FLUX: --urgency=16

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
