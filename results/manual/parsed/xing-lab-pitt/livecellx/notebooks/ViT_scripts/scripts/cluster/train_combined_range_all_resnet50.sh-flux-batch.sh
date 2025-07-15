#!/bin/bash
#FLUX: --job-name=train_csn
#FLUX: -c=8
#FLUX: --queue=dept_gpu
#FLUX: --priority=16

echo
echo $SLURM_JOB_NODELIST
echo
nvidia-smi -L
python=/net/capricorn/home/xing/ken67/.conda/envs/livecell-tracker/bin/python
python train_classify_ViT_classifier_v14_lightning.py\
    --batch_size=32\
    --frame-type combined\
    --model_version "resnet50-frame_all-combined"\
    --model resnet50\
    --max-epochs 100\
