#!/bin/bash
#SBATCH --job-name=fairnas_dpns
#SBATCH --output=logs/%j.%x.%N.out
#SBATCH --error=logs/%j.%x.%N.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --gres=gpu:2
#SBATCH --time=4-00:00:00
#SBATCH --partition=ml_gpu-teslaP100

python src/fairness_train_timm.py --config_path configs_unified_lr/dpn107/config_dpn107_CosFace_SGD_0.1_cosine.yaml #twins_svt_large/config_twins_svt_large_ArcFace_AdamW.yaml
