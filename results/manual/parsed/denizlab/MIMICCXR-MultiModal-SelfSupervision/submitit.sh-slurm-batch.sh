#!/bin/bash
#FLUX: --job-name=RESNET_CLIP_s1000
#FLUX: -c=2
#FLUX: --queue=gpu4_medium
#FLUX: -t=259200
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

source activate deeplearning_general
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
srun python ./main_pretrain.py --batch_size 64 --gpus 4 --num_nodes 1 --max_epochs 50 --lr_img_backbone 1e-4 --lr_text_backbone 1e-4 --img_backbone "resnet2d_50" --max_length 100 --img_embedding_dim 2048 --weight_decay 0.01 --optimizer "adamw" --method "CLIP" --save_dir "model_saved" --pretrained --seed 1000 --num_workers 16 --temperature_mm 0.07 --per_warmup_steps 0.0
