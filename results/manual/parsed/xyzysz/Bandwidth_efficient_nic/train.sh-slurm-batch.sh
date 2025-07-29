#!/bin/bash
#SBATCH --job-name=allon
#SBATCH --mail-user=956347073@qq.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --time=5-00:00:00

python train.py --cuda --pretrained ${SLURM_ARRAY_TASK_ID}
