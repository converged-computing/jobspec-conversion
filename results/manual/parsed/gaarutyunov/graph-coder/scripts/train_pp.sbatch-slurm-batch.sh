#!/bin/bash
#SBATCH --job-name=gc-train
#SBATCH --output=logs/slurm/train/%j.out
#SBATCH --error=logs/slurm/train/%j.err
#SBATCH --mail-user=germanarutyunov@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00
#SBATCH --constraint=type_a|type_b|type_c

chmod +x ./scripts/prepare.sh
source ./scripts/prepare.sh
NCCL_DEBUG=TRACE NCCL_DEBUG_SUBSYS=ALL ACCELERATE_LOG_LEVEL=DEBUG torchrun --standalone --nnodes=1 --nproc_per_node=2 --rdzv_backend=c10d --rdzv_id=$SLURM_JOB_ID --module graph_coder.run --spawn --root "$1" "${@:2}"
