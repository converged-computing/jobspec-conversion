#!/bin/bash
#FLUX: --job-name=arid-arm-6465
#FLUX: -c=8
#FLUX: --queue=fasse_gpu
#FLUX: -t=28740
#FLUX: --urgency=16

source ~/.bashrc
conda activate cuda116
python train_sim_embs.py --silent --sim $((2*SLURM_ARRAY_TASK_ID)) --output results-sim6 --d 6 --method pca &
python train_sim_embs.py --silent --sim $((2*SLURM_ARRAY_TASK_ID)) --output results-sim6 --d 6 --method tsne &
python train_sim_embs.py --silent --sim $((2*SLURM_ARRAY_TASK_ID)) --output results-sim6 --d 6 --method cvae &
python train_sim_embs.py --silent --sim $((2*SLURM_ARRAY_TASK_ID)) --output results-sim6 --d 6 --method crae &
python train_sim_embs.py --silent --sim $((2*SLURM_ARRAY_TASK_ID)) --output results-sim6 --d 6 --method resnet &
python train_sim_embs.py --silent --sim $((2*SLURM_ARRAY_TASK_ID)) --output results-sim6 --d 6 --method unet &
python train_sim_embs.py --silent --sim $((2*SLURM_ARRAY_TASK_ID + 1)) --output results-sim6 --d 6 --method pca &
python train_sim_embs.py --silent --sim $((2*SLURM_ARRAY_TASK_ID + 1)) --output results-sim6 --d 6 --method tsne &
python train_sim_embs.py --silent --sim $((2*SLURM_ARRAY_TASK_ID + 1)) --output results-sim6 --d 6 --method cvae &
python train_sim_embs.py --silent --sim $((2*SLURM_ARRAY_TASK_ID + 1)) --output results-sim6 --d 6 --method crae &
python train_sim_embs.py --silent --sim $((2*SLURM_ARRAY_TASK_ID + 1)) --output results-sim6 --d 6 --method resnet &
python train_sim_embs.py --silent --sim $((2*SLURM_ARRAY_TASK_ID + 1)) --output results-sim6 --d 6 --method unet &
wait
