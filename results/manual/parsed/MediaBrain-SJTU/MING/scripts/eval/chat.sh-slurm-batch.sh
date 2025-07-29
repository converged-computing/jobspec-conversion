#!/bin/bash
#SBATCH --job-name=ming_chat
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH --time=5-00:00:00
#SBATCH --constraint=ntasks-per-node=1

srun --jobid $SLURM_JOBID python ming/serve/cli.py \
    --model_path /mnt/petrelfs/liaoyusheng/oss/download_models/MING-7B \
    --conv_template bloom \
    --max_new_token 512 \
    --beam_size 3 \
    --temperature 1.2
