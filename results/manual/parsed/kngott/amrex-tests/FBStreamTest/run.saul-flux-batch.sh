#!/bin/bash
#FLUX: --job-name=hanky-hope-6589
#FLUX: --urgency=16

export CRAY_ACCEL_TARGET='nvidia80'
export AMREX_CUDA_ARCH='8.0'
export MPICH_OFI_NIC_POLICY='NUMA'
export MPICH_GPU_SUPPORT_ENABLED='1'

export CRAY_ACCEL_TARGET=nvidia80
export AMREX_CUDA_ARCH=8.0
export MPICH_OFI_NIC_POLICY=NUMA
export MPICH_GPU_SUPPORT_ENABLED=1
EXE=./main3d.gnu.TPROF.MPI.CUDA.ex
EXE=./main3d.gnu.DEBUG.TPROF.MTMPI.CUDA.ex
INPUTS="inputs_2"
echo "GPU_AWARE_MPI = ${GPU_AWARE_MPI}"
srun --cpu-bind=cores bash -c "export CUDA_VISIBLE_DEVICES=\$((3-SLURM_LOCALID));
    ${EXE} ${INPUTS} ${GPU_AWARE_MPI}" 
