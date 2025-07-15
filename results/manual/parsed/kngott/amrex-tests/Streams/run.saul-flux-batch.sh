#!/bin/bash
#FLUX: --job-name=eccentric-despacito-0336
#FLUX: --urgency=16

export CRAY_ACCEL_TARGET='nvidia80'
export AMREX_CUDA_ARCH='8.0'
export MPICH_OFI_NIC_POLICY='NUMA'
export MPICH_GPU_SUPPORT_ENABLED='1'

export CRAY_ACCEL_TARGET=nvidia80
export AMREX_CUDA_ARCH=8.0
export MPICH_OFI_NIC_POLICY=NUMA
export MPICH_GPU_SUPPORT_ENABLED=1
EXE=./main3d.gnu.CUDA.ex
GPU_AWARE_MPI="amrex.the_arena_is_managed=0 amrex.use_gpu_aware_mpi=1"
echo "GPU_AWARE_MPI = ${GPU_AWARE_MPI}"
srun --cpu-bind=cores bash -c "export CUDA_VISIBLE_DEVICES=\$((3-SLURM_LOCALID));
    ${EXE} ${INPUTS} ${GPU_AWARE_MPI}" 
