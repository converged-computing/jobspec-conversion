#!/bin/bash
#FLUX: --job-name=bloated-platanos-7194
#FLUX: -c=6
#FLUX: --urgency=16

export PYTHONUNBUFFERED='1'
export OMP_NUM_THREADS='1'

pwd
hostname
date
echo starting job...
source ~/.bashrc
export PYTHONUNBUFFERED=1
export OMP_NUM_THREADS=1
root=/root/data1/ym/google_tide/TiDE
cd ${root}
name=TiDE
print_tofile=False
datadir=${root}/data
cuda=True
dataset=ETTm2
epoch=100
batch_size=512
cuda=True
lr=6e-5
ckpt_path=/root/data1/ym/google_tide/TiDE/result/dataset_${dataset}
save_path=${ckpt_path}
drop_prob=0.3
mkdir -p ${ckpt_path}
cd src
pwd
CUDA_VISIBLE_DEVICES=0 \
    python train.py \
    --name ${name} \
    --print-tofile ${print_tofile} \
    --ckpt_path ${ckpt_path} \
    --datadir ${datadir} \
    --dataset ${dataset} \
    --save_path ${save_path} \
    --epoch ${epoch} \
    --batch_size ${batch_size} \
    --cuda ${cuda} \
    --lr ${lr} \
    --drop_prob ${drop_prob} \
    --hidden_size=256 \
    --num_encoder_layers=2 \
    --num_decoder_layers=2 \
    --decoder_output_dim=16 \
    --temporal_decoder_hidden=128 \
    --pred_len=96 \
    --lookback_len=720 \
    --layer_norm=Ture \
    --revin=True\
