#!/bin/bash
#SBATCH --job-name=Symbolic-PPO_seed_%a
#SBATCH --account=
#SBATCH --output=slurm_logs/Symbolic-PPO_seed_%a.out
#SBATCH --error=slurm_logs/Symbolic-PPO_seed_%a.err
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
srun experiments/slurm/train_symbolic_ppo.sh BabyAI-MixedTrainLocal-v0 MTRL 6 ${SLURM_ARRAY_TASK_ID}
