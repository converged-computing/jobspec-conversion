#!/bin/bash
#SBATCH --job-name=predehaze
#SBATCH --output=/scratch/08310/rs821505/train_outputs/run_mp.o%j
#SBATCH --error=/scratch/08310/rs821505/train_outputs/run_mp.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=3

export MASTER_PORT='12340'
export MASTER_ADDR='$master_addr'
export TORCH_DISTRIBUTED_DEBUG='INFO'

export MASTER_PORT=12340
echo "NODELIST="${SLURM_NODELIST}
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
echo "Parent IP="$MASTER_ADDR
echo "Parent Port="$MASTER_PORT
module add gcc
export TORCH_DISTRIBUTED_DEBUG=INFO
srun python main.py --slurm_env_var --template Pre_Dehaze_revidereduced
