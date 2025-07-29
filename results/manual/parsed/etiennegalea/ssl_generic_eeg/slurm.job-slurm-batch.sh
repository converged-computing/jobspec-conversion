#!/bin/bash
#SBATCH --output=output.log
#SBATCH --error=error.log
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:15:00
#SBATCH --constraint=ntasks-per-node=16,TitanX

source /home/ega470/.bashrc
cd /var/scratch/ega470/ssl_thesis/
python -V
python -u /var/scratch/ega470/ssl_thesis/ssl_rl_finetuning.py --dataset_name='space_bambi' --n_jobs=16 --window_size_s=5 --sfreq=100 --batch_size=512 --connectivity_plot=False --edge_bundling_plot=False -p=False
