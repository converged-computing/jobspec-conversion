#!/bin/bash
#FLUX: --job-name=raven
#FLUX: -c=12
#FLUX: --queue=learnai4rl
#FLUX: -t=0
#FLUX: --priority=16

srun python raven/test.py \
    data.modality=video \
    data/dataset=lrs3 \
    experiment_name=vsr_prelrs3vox2avs_large_ftlrs3_braven_test \
    model/visual_backbone=resnet_transformer_large \
    model.pretrained_model_path=ckpts/vsr_prelrs3vox2avs_large_ftlrs3_braven.pth \
