#!/bin/bash
#FLUX: --job-name=6G
#FLUX: -N=1200
#FLUX: --queue=pbatch
#FLUX: -t=86400
#FLUX: --urgency=16

export PETSC_DIR='/g/g15/mcgurn4/petsc'
export PETSC_ARCH='arch-ablate-opt-gcc" # arch-ablate-debug or arch-ablate-opt'
export PKG_CONFIG_PATH='${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH'
export HDF5_ROOT='${PETSC_DIR}/${PETSC_ARCH}"  '
export PATH='${PETSC_DIR}/${PETSC_ARCH}/bin:$PATH'
export TITLE='6G-1200'
export VELOCITY='min(3.985120454,t*3.985120454/.01),0.0,0.0'

module load mkl/2019.0
module load valgrind/3.16.1
module load gcc/10.2.1
module load  cmake/3.21.1 
export PETSC_DIR="/g/g15/mcgurn4/petsc"
export PETSC_ARCH="arch-ablate-opt-gcc" # arch-ablate-debug or arch-ablate-opt
export PKG_CONFIG_PATH="${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH"
export HDF5_ROOT="${PETSC_DIR}/${PETSC_ARCH}"  
export PATH="${PETSC_DIR}/${PETSC_ARCH}/bin:$PATH"
mkdir tmp_$SLURM_JOBID
cd tmp_$SLURM_JOBID
export TITLE=6G-1200
export VELOCITY="min(3.985120454,t*3.985120454/.01),0.0,0.0"
srun -n43200 /g/g15/mcgurn4/ablateOpt/ablate \
	--input /p/lustre2/ubchrest/ablateInputs/slabBurner3D/slabBurner.3D.yaml \
	-yaml::environment::title $TITLE \
    -yaml::solvers::[1]::processes::[0]::velocity \"$VELOCITY\"
echo 'Done'
