#!/bin/bash
#FLUX: --job-name=fuzzy-fudge-5734
#FLUX: -N=2
#FLUX: -t=900
#FLUX: --urgency=16

source /home/ega470/.bashrc
cd /var/scratch/ega470/ssl_thesis/
python -V
python -u /var/scratch/ega470/ssl_thesis/ssl_rl_finetuning.py --dataset_name='space_bambi' --n_jobs=16 --window_size_s=5 --sfreq=100 --batch_size=512 --connectivity_plot=False --edge_bundling_plot=False -p=False
