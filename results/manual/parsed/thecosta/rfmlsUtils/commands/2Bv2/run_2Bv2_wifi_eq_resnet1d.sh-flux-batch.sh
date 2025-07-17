#!/bin/bash
#FLUX: --job-name=carnivorous-dog-2849
#FLUX: --queue=multigpu
#FLUX: -t=86400
#FLUX: --urgency=16

echo "Start JOB!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
mkdir -p /home/bruno/results/2Bv2/wifi/equalized/resnet1d/
python -u /home/bruno/RFMLS/train_val_framework/test_framework.py \
    --exp_name 2Bv2_wifi_raw_resnet1d \
    --base_path /scratch/RFMLS/dec18_darpa/v3_list/equalized/2Bv2/phy_payload_no_offsets_iq \
    --stats_path /scratch/RFMLS/dec18_darpa/v3_list/equalized/2Bv2/phy_payload_no_offsets_iq \
    --save_path /home/bruno/results/2Bv2/wifi/equalized/resnet1d/ \
    --devices 50 \
    --file_type pickle \
    --model_flag  resnet1d\
    --slice_size 256 \
    --batchnorm False \
    --batch_size 128 \
    --add_padding True \
    --lr 0.0001 \
    --K 10 \
    --epochs 30 \
    --normalize True \
    --generator new \
    --training_strategy big \
    --multigpu False \
    --id_gpu $1 \
    --train True \
    --test True \
    --patience 5 \
    --channels 128 \
    --fc1 256 \
    --fc2 128 \
    --cnn_stack 5 \
    --dropout_flag False \
    --early_stopping True \
    --test_stride 16 \
    --fc_stack 2 \
    --decay 0.0 \
    --shrink 1 \
    > /home/bruno/results/2Bv2/wifi/equalized/resnet1d/log.out \
    2> /home/bruno/results/2Bv2/wifi/equalized/resnet1d/log.err
