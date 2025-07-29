#!/bin/bash
#SBATCH --job-name=train_adv
#SBATCH --output=logs/train_%j.out.log
#SBATCH --error=logs/train_%j.err.log
#SBATCH --mail-user=lucia.trastulla@fht.org
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=20G
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpuq
#SBATCH --constraint=ntasks-per-node=1

module load cuda11.7/toolkit/11.7.1
module load cudnn8.5-cuda11.7/8.5.0.96
source ${HOME}/miniforge3/etc/profile.d/conda.sh
conda activate VAE_momics_v2
GROUP_PATH='/group/iorio/lucia/'
python train/training.py \
    --folder=experiment_1 \
    --gex_feature_file=${GROUP_PATH}'Multiomic_VAE/data/preprocessed/gene_expression_all.csv.gz' \
    --ngene='all' \
    --no-norm_feat \
    --no-only_shared
python train/training.py \
    --folder=experiment_1 \
    --gex_feature_file=${GROUP_PATH}'Multiomic_VAE/data/preprocessed/gene_expression_all.csv.gz' \
    --ngene='all' \
    --norm_feat \
    --no-only_shared
