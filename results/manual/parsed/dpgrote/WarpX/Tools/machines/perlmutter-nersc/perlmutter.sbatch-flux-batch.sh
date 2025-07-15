#!/bin/bash
#FLUX: --job-name=carnivorous-chip-0232
#FLUX: --exclusive
#FLUX: --priority=16

export MPICH_OFI_NIC_POLICY='GPU'
export SRUN_CPUS_PER_TASK='32'

EXE=./warpx
INPUTS=inputs_small
export MPICH_OFI_NIC_POLICY=GPU
export SRUN_CPUS_PER_TASK=32
GPU_AWARE_MPI=""
srun --cpu-bind=cores bash -c "
    export CUDA_VISIBLE_DEVICES=\$((3-SLURM_LOCALID));
    ${EXE} ${INPUTS} ${GPU_AWARE_MPI}" \
  > output.txt
