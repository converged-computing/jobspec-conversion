#!/bin/bash
#FLUX: --job-name=chocolate-sundae-8016
#FLUX: --priority=16

export PETSC_DIR='/g/g20/lobad1/petsc'
export PETSC_ARCH='arch-ablate-opt-gcc" # arch-ablate-debug or arch-ablate-opt'
export PKG_CONFIG_PATH='${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH'
export HDF5_ROOT='${PETSC_DIR}/${PETSC_ARCH}"  '
export PATH='${PETSC_DIR}/${PETSC_ARCH}/bin:$PATH'

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
srun -n288 /g/g20/lobad1/ablateOpt/ablate \
        --input /p/lustre1/lobad1/ablateInputs/peregrineMotor.3D.V06/peregrineMotor.3D.V06.yaml \
        -yaml::environment::title 2Dn8_debug_test \
        -yaml::timestepper::arguments::ts_max_steps 50000000 \
        -yaml::timestepper::domain::options::dm_refine 0
echo 'Done'
