#!/bin/bash
#FLUX: --job-name=my_cscs_job
#FLUX: -N=2
#FLUX: -c=12
#FLUX: -t=600
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export NCCL_DEBUG='INFO'
export NCCL_IB_HCA='ipogif0'
export NCCL_IB_CUDA_SUPPORT='1'

module load daint-gpu
module load PyTorch
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export NCCL_DEBUG=INFO
export NCCL_IB_HCA=ipogif0
export NCCL_IB_CUDA_SUPPORT=1
. /users/your_account/miniconda3/bin/activate pt38
cd your_code_path
srun \
python -u your_code.py  \
--epochs 90 \
--model resnet50 \
> ${SLURM_JOBID}.out 2> ${SLURM_JOBID}.err
