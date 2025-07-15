#!/bin/bash
#FLUX: --job-name=dinosaur-omelette-9978
#FLUX: --exclusive
#FLUX: --urgency=16

export MPICH_OFI_NIC_POLICY='GPU'
export SRUN_CPUS_PER_TASK='16'
export OMP_NUM_THREADS='${SRUN_CPUS_PER_TASK}'

EXE=./warpx
INPUTS=inputs
export MPICH_OFI_NIC_POLICY=GPU
export SRUN_CPUS_PER_TASK=16
export OMP_NUM_THREADS=${SRUN_CPUS_PER_TASK}
GPU_AWARE_MPI="amrex.use_gpu_aware_mpi=1"
srun --cpu-bind=cores bash -c "
    export CUDA_VISIBLE_DEVICES=\$((3-SLURM_LOCALID));
    ${EXE} ${INPUTS} ${GPU_AWARE_MPI}" \
  > output.txt
