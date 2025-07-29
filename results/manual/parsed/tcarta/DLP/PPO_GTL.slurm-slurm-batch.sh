#!/bin/bash
#SBATCH --job-name=PPO_GTL_%a
#SBATCH --account=imi@v100
#SBATCH --output=slurm_logs/PPO_GTL_%a.out
#SBATCH --error=slurm_logs/PPO_GTL_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:1
#SBATCH --time=10:00:00
#SBATCH --qos=qos_gpu-t3
#SBATCH --constraint=ntasks-per-node=1,v100-32g
#SBATCH --array=1-2

module purge
module load python/3.8.2
conda activate dlp
srun scripts/train_ppo_baseline.sh BabyAI-GoToLocal-v0 GTL 6 ${SLURM_ARRAY_TASK_ID}
