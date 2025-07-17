#!/bin/bash
#FLUX: --job-name=drivaer
#FLUX: -N=2
#FLUX: --queue=hpc
#FLUX: --urgency=16

export FOAM_MPIRUN_FLAGS='-mca pml ucx $(env |grep 'WM_\|FOAM_' | cut -d'=' -f1 | sed 's/^/-x /g' | tr '\n' ' ') -x MPI_BUFFER_SIZE -x UCX_IB_MLX5_DEVX=n -x UCX_POSIX_USE_PROC_LINK=n -x PATH -x LD_LIBRARY_PATH'

np=$SLURM_NTASKS
n=$SLURM_NNODES
ppn=$SLURM_CPUS_ON_NODE
source /cvmfs/pilot.eessi-hpc.org/versions/2021.12/init/bash
ml OpenFOAM/9-foss-2021a
source $FOAM_BASH
tutorial_path=incompressible/simpleFoam/drivaerFastback
allrun_args="-c $np -m M"
local_path=$HOME/openfoam_tutorial_runs
mkdir -p $local_path
casedir=$local_path/$(basename $tutorial_path)_${n}x${ppn}_$(date +%Y%m%d_%H%M%S)
cp -r $FOAM_TUTORIALS/$tutorial_path $casedir
pushd $casedir
sed -i '/RunFunctions/a source <(declare -f runParallel | sed "s/mpirun/SLURM_EXPORT_ENV=ALL mpirun \\\$FOAM_MPIRUN_FLAGS/g")' Allrun
sed -i 's#/bin/sh#/bin/bash#g' Allrun
export FOAM_MPIRUN_FLAGS="-mca pml ucx $(env |grep 'WM_\|FOAM_' | cut -d'=' -f1 | sed 's/^/-x /g' | tr '\n' ' ') -x MPI_BUFFER_SIZE -x UCX_IB_MLX5_DEVX=n -x UCX_POSIX_USE_PROC_LINK=n -x PATH -x LD_LIBRARY_PATH"
gunzip constant/geometry/*
mv constant/geometry constant/triSurface
sed -i 's/# runApplication reconstructPar/runApplication reconstructPar/g' Allrun
./Allrun $allrun_args
touch case.foam
