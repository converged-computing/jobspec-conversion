#!/bin/bash
#FLUX: --job-name=spicy-pot-2066
#FLUX: --urgency=16

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
srun -n1800 /g/g20/lobad1/ablateOptRocket/ablate \
        --input /p/lustre1/lobad1/ablateInputs/peregrineMotor.2D.V06/peregrineMotor.2D.V06.rad.yaml \
        -yaml::environment::title 2Dn50peregrine_ignite8_G150_ref0_petscStep_rad_rocketMonitor \
        -yaml::timestepper::arguments::ts_max_steps 100000000 \
        -yaml::timestepper::domain::fields::[0]::conservedFieldOptions::petscfv_type leastsquares
        -yaml::timestepper::domain::options::dm_refine 0
echo 'Done'
