#!/bin/bash
#FLUX: --job-name=2dSlab
#FLUX: -N=128
#FLUX: --queue=pbatch
#FLUX: -t=86400
#FLUX: --urgency=16

export PETSC_DIR='/g/g20/lobad1/petsc'
export PETSC_ARCH='arch-ablate-opt-gcc" # arch-ablate-debug or arch-ablate-opt'
export PKG_CONFIG_PATH='${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH'
export HDF5_ROOT='${PETSC_DIR}/${PETSC_ARCH}"  '
export PATH='${PETSC_DIR}/${PETSC_ARCH}/bin:$PATH'

module load mkl/2019.0
module load valgrind/3.16.1
module load gcc/10.2.1
module load  cmake/3.21.1 
export PETSC_DIR="/g/g20/lobad1/petsc"
export PETSC_ARCH="arch-ablate-opt-gcc" # arch-ablate-debug or arch-ablate-opt
export PKG_CONFIG_PATH="${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH"
export HDF5_ROOT="${PETSC_DIR}/${PETSC_ARCH}"  
export PATH="${PETSC_DIR}/${PETSC_ARCH}/bin:$PATH"
mkdir tmp_$SLURM_JOBID
cd tmp_$SLURM_JOBID
srun -n4608 /g/g20/lobad1/ablateOpt/ablate \
	--input /p/lustre1/lobad1/ablateInputs/slabBurner.2D.V01/slabBurner.2D.V01.yaml \
	-yaml::environment::title 2Dn128 \
	-yaml::timestepper::domain::faces [1120,160]
echo 'Done'
