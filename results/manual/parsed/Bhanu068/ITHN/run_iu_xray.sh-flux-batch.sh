#!/bin/bash
#FLUX: --job-name=adorable-lamp-9918
#FLUX: -c=4
#FLUX: -t=518400
#FLUX: --urgency=16

conda activate gpu
python main.py \
    --image_dir data/iu_xray/images \
    --ann_path data/iu_xray/topk_pos_neg_iu_xray.json \
    --dataset_name iu_xray \
    --max_seq_length 60 \
    --threshold 3 \
    --epochs 100 \
    --batch_size 16 \
    --lr_ve 1e-4 \
    --lr_ed 5e-4 \
    --step_size 10 \
    --gamma 0.8 \
    --num_layers 3 \
    --num_heads 8 \
    --topk 32 \
    --d_vf 2048 \
    --d_model 512 \
    --cmm_size 2048 \
    --cmm_dim 512 \
    --seed 7580 \
    --beam_size 3 \
    --save_dir /nfsdata/data/bhanuv/results/iu_xray \
    --log_period 50 \
    --model_name "r2gencmn_ithn" \
    --early_stop 25 \
    --visual_extractor "resnet101" \
    --alpha 0.01
