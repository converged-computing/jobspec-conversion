#!/bin/bash
#FLUX: --job-name=pn_ucf_visualization
#FLUX: -c=16
#FLUX: --urgency=16

export PYTORCH_CUDA_ALLOC_CONF='max_split_size_mb:32'

wandb offline
export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:32
python3 /home/cpanighe/ProgressPrediction/code/main.py \
    --seed 42 \
    --experiment_name pn_ucf_visualisation \
    --wandb_name pn_ucf_1 \
    --wandb_project pn_ucf_1 \
    --dataset ucf24 \
    --data_dir rgb-images \
    --bboxes \
    --train_split train_small.txt \
    --test_split test_small.txt \
    --batch_size 1 \
    --iterations 50000 \
    --network progressnet \
    --backbone resnet18 \
    --load_backbone resnet18.pth \
    --num_workers 2 \
    --max_length 300 \
    --load_experiment pn_ucf_resnet18_mask_pe_segments_progress_change \
    --load_iteration 50000 \
    --save_dir pn_ucf_resnet18_mask_pe_segments_progress_change
