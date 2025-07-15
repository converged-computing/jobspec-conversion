#!/bin/bash
#FLUX: --job-name=angry-citrus-2569
#FLUX: -c=6
#FLUX: --urgency=16

export PYTHONUNBUFFERED='1'
export OMP_NUM_THREADS='1'

pwd
hostname
date
echo starting job...
source ~/.bashrc
conda activate lzhenv
export PYTHONUNBUFFERED=1
export OMP_NUM_THREADS=1
root=/scratch/zhliu/repos/TiDE
cd ${root}
name=TiDE
print_tofile=True
datadir=${root}/data
cuda=True
dataset=ETTh1
epoch=20
batch_size=8
cuda=True
lr=3.82e-5
ckpt_path=/scratch/zhliu/checkpoints/TiDE/epoch_${epoch}/batch_size_${batch_size}/lr_${lr}
save_path=${ckpt_path}
drop_prob=0.3
mkdir -p ${ckpt_path}
cd src
pwd
CUDA_VISIBLE_DEVICES=0,1,2,3  python train.py \
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
