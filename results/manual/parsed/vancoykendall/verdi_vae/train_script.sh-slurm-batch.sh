#!/bin/bash
#SBATCH --output=job_logs/train_script.sh.log-%j-%a
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --gres=gpu:volta:1
#SBATCH --array=1-4

echo test1
module load anaconda/2020b cuda/10.2 nccl/2.5.6-cuda10.2
echo test2
echo test3
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT
python main.py btcvae_cardamage_128 -d cardamagemedium -b 64 -l btcvae --lr 0.001 -e 200 --checkpoint-every 10 --task-id $SLURM_ARRAY_TASK_ID --task-count $SLURM_ARRAY_TASK_COUNT
