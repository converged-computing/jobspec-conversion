#!/bin/bash
#FLUX: --job-name=stinky-nalgas-2760
#FLUX: --priority=16

export CRAY_ACCEL_TARGET='nvidia80'
export AMREX_CUDA_ARCH='8.0'
export MPICH_OFI_NIC_POLICY='GPU'
export MPICH_GPU_SUPPORT_ENABLED='1'

export CRAY_ACCEL_TARGET=nvidia80
export AMREX_CUDA_ARCH=8.0
export MPICH_OFI_NIC_POLICY=GPU
export MPICH_GPU_SUPPORT_ENABLED=1
EXE=./main3d.gnu.TPROF.MTMPI.CUDA.ex
INPUTS="inputs"
GPU_AWARE_MPI="amrex.use_gpu_aware_mpi=1"
echo -e "GPU_AWARE_MPI = ${GPU_AWARE_MPI}\n"
srun --cpu-bind=cores bash -c "export CUDA_VISIBLE_DEVICES=\$((3-SLURM_LOCALID));
    ${EXE} ${INPUTS} ${GPU_AWARE_MPI}" 
