#!/bin/bash
#FLUX: --job-name=stinky-dog-3249
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
srun -n1440 /g/g20/lobad1/ablateOpt/ablate \
        --input /p/lustre1/lobad1/ablateInputs/peregrineMotor.2D.V05/peregrineMotor.2D.V05.yaml \
        -yaml::environment::title 2Dn40peregrine_ignite5_G10_mV4.2_ref0_petscStep \
        -yaml::timestepper::arguments::ts_max_steps 100000000 \
        -yaml::timestepper::domain::options::dm_refine 0
echo 'Done'
