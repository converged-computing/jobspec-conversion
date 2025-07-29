#!/bin/bash
#SBATCH --job-name=clustering
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32000M
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu_short

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
