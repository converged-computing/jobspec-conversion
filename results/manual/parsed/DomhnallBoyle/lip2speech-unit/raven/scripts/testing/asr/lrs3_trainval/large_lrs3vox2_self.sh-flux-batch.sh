#!/bin/bash
#FLUX: --job-name=raven
#FLUX: -c=12
#FLUX: --queue=learnai4rl
#FLUX: -t=0
#FLUX: --urgency=16

srun python raven/test.py \
    data.modality=audio \
    data/dataset=lrs3_trainval \
    experiment_name=asr_prelrs3vox2_large_ftlrs3trainval_selftrain_test \
    model/visual_backbone=resnet_transformer_large \
    model.pretrained_model_path=ckpts/asr_prelrs3vox2_large_ftlrs3trainvalvox2_selftrain.pth \
