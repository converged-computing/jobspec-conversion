#!/bin/bash
#FLUX: --job-name=clustering
#FLUX: --queue=gpu_short
#FLUX: -t=86400
#FLUX: --priority=16

module load lang/perl/5.30.0-bioperl-gcc
module load lang/python/anaconda/3.8-2020.07
nvidia-smi -q
cd "${SLURM_SUBMIT_DIR}"
source venv/bin/activate
python -u news-tls/experiments/train.py \
	--dataset dataset/t17 \
	--method rl-datewise \
	--resources news-tls/resources/datewise \
	--output rl_results/clust/t17 \
	--preference preference \
	--epochs 5
