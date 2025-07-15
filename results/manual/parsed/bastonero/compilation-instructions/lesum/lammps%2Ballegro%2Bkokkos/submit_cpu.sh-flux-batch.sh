#!/bin/bash
#FLUX: --job-name=LAMMPS-ALLEGRO
#FLUX: -c=2
#FLUX: --queue=mpi
#FLUX: -t=1200
#FLUX: --urgency=16

export LAMMPS_BIN='/path/to/lammps/build/bin'
export PATH='$LAMMPS_BIN:$PATH'
export TORCH_PATH='/home1/bastonero/builds/libtorch/1.11.0/cpu/lib/'
export LD_PRELOAD='$TORCH_PATH/libtorch.so \'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module purge
module load intel/oneapi-2023.1.0
module load icc/2023.1.0
module load mkl/2023.1.0 
module load openmpi/4.1.5
export LAMMPS_BIN=/path/to/lammps/build/bin
export PATH=$LAMMPS_BIN:$PATH
export TORCH_PATH=/home1/bastonero/builds/libtorch/1.11.0/cpu/lib/
export LD_PRELOAD="$TORCH_PATH/libtorch.so \
        $TORCH_PATH/libtorch_cpu.so \
        $TORCH_PATH/libc10.so \
        $LD_PRELOAD \
"
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
