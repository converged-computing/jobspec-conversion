#!/bin/bash
#FLUX: --job-name=sticky-toaster-7149
#FLUX: --priority=16

export OMP_NUM_THREADS='7'
export RMG_NUM_THREADS='5'
export MPICH_OFI_NIC_POLICY='NUMA'
export MPICH_GPU_SUPPORT_ENABLED='0'

export OMP_NUM_THREADS=7
export RMG_NUM_THREADS=5
export MPICH_OFI_NIC_POLICY=NUMA
export MPICH_GPU_SUPPORT_ENABLED=0
module load PrgEnv-gnu/8.3.3
module load bzip2
module load boost/1.79.0-cxx17
module load cray-fftw
module load cray-hdf5-parallel
module load craype-accel-amd-gfx90a
module load rocm/5.4.3
srun -AMAT151 --ntasks=32 -u -c7 --gpus-per-node=8  --ntasks-per-gpu=1 --gpu-bind=closest ./rmg-gpu input
