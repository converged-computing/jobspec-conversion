#!/bin/bash
#FLUX: --job-name=TEST
#FLUX: -c=12
#FLUX: --queue=gpu
#FLUX: -t=1200
#FLUX: --priority=16

export LAMMPS_BIN='/home1/bastonero/builds/lammps/builds/stable_2Aug2023_update3/kokkos-gpu-ompi-cuda-12.1-gcc-12-libtorch-1.11.0/bin/'
export PATH='$LAMMPS_BIN:$PATH'
export TORCH_PATH='/home1/bastonero/builds/libtorch/1.11.0/cu113/lib'
export LD_PRELOAD='$TORCH_PATH/libtorch.so \'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'

module purge
module load gcc/12
module load CUDA/12.1
module load openmpi-cuda/4.1.5
nvidia-cuda-mps-control -d
export LAMMPS_BIN=/home1/bastonero/builds/lammps/builds/stable_2Aug2023_update3/kokkos-gpu-ompi-cuda-12.1-gcc-12-libtorch-1.11.0/bin/
export PATH=$LAMMPS_BIN:$PATH
export TORCH_PATH=/home1/bastonero/builds/libtorch/1.11.0/cu113/lib
export LD_PRELOAD="$TORCH_PATH/libtorch.so \
    $TORCH_PATH/libtorch_cuda.so \
    $TORCH_PATH/libc10.so \
    $TORCH_PATH/libtorch_cpu.so \
    $TORCH_PATH/libtorch_cuda_cpp.so \
    $TORCH_PATH/libtorch_cuda_cu.so \
    $LD_PRELOAD \
"
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
mpirun -np 1 lmp -k on g 2 t 12 -sf kk -in in.lj
