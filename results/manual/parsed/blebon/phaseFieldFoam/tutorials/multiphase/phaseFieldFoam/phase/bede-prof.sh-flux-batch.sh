#!/bin/bash
#FLUX: --job-name=OF10_NvcppOpt_Phase
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --urgency=16

export NVLOCALRC='$HOME/localrc'
export application='`getApplication`'

pwd; hostname; date
module load /nobackup/projects/bddir15/hpc_sdk/modulefiles/nvhpc/23.1
export NVLOCALRC=$HOME/localrc
source $HOME/OpenFOAM/${USER}-10/etc/bashrc WM_COMPILER=Nvcpp
unset FOAM_SIGFPE
conda activate base
source $WM_PROJECT_DIR/bin/tools/RunFunctions
export application=`getApplication`
nvidia-smi > log.nvidia-smi
if [ ! -f log.decomposePar ]; then
    ./Allrun.pre
fi
nProcs=$(foamDictionary system/decomposeParDict -entry numberOfSubdomains -value)
echo "Running $application in parallel on $(pwd) using $nProcs processes"
nsys profile -t nvtx,cuda -o report_bind -f true  --stats=true /nobackup/projects/bddir15/hpc_sdk/Linux_ppc64le/23.1/comm_libs/mpi/bin/mpirun -n $nProcs $FOAM_USER_APPBIN/$application -parallel > log.$application # 2>&1
runApplication reconstructPar
./Allpost
date
