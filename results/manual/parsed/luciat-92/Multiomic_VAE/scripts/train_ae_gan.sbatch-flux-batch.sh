#!/bin/bash
#FLUX: --job-name=train_adv
#FLUX: -c=2
#FLUX: --queue=gpuq
#FLUX: -t=86400
#FLUX: --priority=16

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
