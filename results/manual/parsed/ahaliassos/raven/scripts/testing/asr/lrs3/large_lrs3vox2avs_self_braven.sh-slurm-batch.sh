#!/bin/bash
#SBATCH --job-name=raven
#SBATCH --account=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:1
#SBATCH --partition=learnai4rl
#SBATCH --constraint=ntasks-per-node=1
#SBATCH: --no-requeue

srun python raven/test.py \
    data.modality=audio \
    data/dataset=lrs3 \
    experiment_name=asr_prelrs3vox2avs_large_ftlrs3vox2avs_selftrain_braven_test \
    model/visual_backbone=resnet_transformer_large \
    model.pretrained_model_path=ckpts/asr_prelrs3vox2avs_large_ftlrs3vox2avs_selftrain_braven.pth \
