#!/bin/bash
#FLUX: --job-name=lovable-itch-5604
#FLUX: -t=86400
#FLUX: --urgency=16

source /home/ega470/.bashrc
cd /var/scratch/ega470/ssl_thesis/
python -V
python -u /var/scratch/ega470/ssl_thesis/ssl_rl_finetuning.py --dataset_name='sleep_staging' --n_jobs=16 --window_size_s=5 --sfreq=100 --batch_size=256 --subject_size='sample' --connectivity_plot=False --edge_bundling_plot=False
