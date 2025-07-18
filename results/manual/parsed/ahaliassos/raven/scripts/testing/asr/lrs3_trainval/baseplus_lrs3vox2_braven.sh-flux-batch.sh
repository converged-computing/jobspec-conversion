#!/bin/bash
#FLUX: --job-name=raven
#FLUX: -c=12
#FLUX: --queue=learnai4rl
#FLUX: -t=0
#FLUX: --urgency=16

srun python raven/test.py \
    data.modality=audio \
    data/dataset=lrs3_trainval \
    experiment_name=asr_prelrs3vox2_baseplus_ftlrs3trainval_braven_test \
    model/visual_backbone=resnet_transformer_baseplus \
    model.visual_backbone.ddim=256 \
    model.visual_backbone.dheads=4 \
    model.visual_backbone.dunits=2048 \
    model.visual_backbone.dlayers=6 \
    model.pretrained_model_path=ckpts/asr_prelrs3vox2_baseplus_ftlrs3trainval_braven.pth \
