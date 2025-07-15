#!/bin/bash
#FLUX: --job-name=fuzzy-frito-9322
#FLUX: --priority=16

export PETSC_DIR='/g/g20/lobad1/petsc'
export PETSC_ARCH='arch-ablate-opt-gcc" # arch-ablate-debug or arch-ablate-opt'
export PKG_CONFIG_PATH='${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH'
export HDF5_ROOT='${PETSC_DIR}/${PETSC_ARCH}"  '
export PATH='${PETSC_DIR}/${PETSC_ARCH}/bin:$PATH'
export TITLE='3Dn128'

module load mkl/2019.0
module load valgrind/3.16.1
module load gcc/10.2.1
module load cmake/3.21.1
export PETSC_DIR="/g/g20/lobad1/petsc"
export PETSC_ARCH="arch-ablate-opt-gcc" # arch-ablate-debug or arch-ablate-opt
export PKG_CONFIG_PATH="${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH"
export HDF5_ROOT="${PETSC_DIR}/${PETSC_ARCH}"  
export PATH="${PETSC_DIR}/${PETSC_ARCH}/bin:$PATH"
mkdir tmp_$SLURM_JOBID
cd tmp_$SLURM_JOBID
export TITLE=3Dn128
srun -n4608 /g/g20/lobad1/ablateOpt/ablate \
	--input /p/lustre1/lobad1/ablateInputs/peregrineMotorChem.3D.V02/peregrineMotor.Pgs.3D.V02.yaml \
	-yaml::environment::title 3Dn128 \
	-yaml::timestepper::arguments::ts_max_steps 250 \
	-yaml::timestepper::domain::faces [960,144,144]
echo 'Done'
