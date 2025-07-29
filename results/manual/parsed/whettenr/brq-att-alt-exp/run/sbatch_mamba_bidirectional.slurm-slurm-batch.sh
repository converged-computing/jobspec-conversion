#!/bin/bash
#SBATCH --job-name=ssl-mamba
#SBATCH --account=uul@v100
#SBATCH --output=ssl-mamba%j.log
#SBATCH --error=ssl-mamba%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:8
#SBATCH --time=20:00:00
#SBATCH --partition=gpu_p2
#SBATCH --array=0-6%1

export TORCH_NCCL_BLOCKING_WAIT='1'
export MASTER='$(hostname --ip-address)'
export MASTER_PORT='$((RANDOM%1000+20000))'

set -ex # activer l’echo des commandes
cd ${SLURM_SUBMIT_DIR}
export TORCH_NCCL_BLOCKING_WAIT=1
export MASTER=$(hostname --ip-address)
export MASTER_PORT=$((RANDOM%1000+20000))
srun run_mamba_bidirectional.sh
