#!/bin/bash
#FLUX: --job-name=CycleGAN_01
#FLUX: -c=4
#FLUX: --queue=cuda
#FLUX: -t=60
#FLUX: --urgency=16

module load nvidia/cudasdk/10.1
module load intel/python/3/2019.4.088
source /home/mla_group_13/.bashrc
conda activate mla39
PORT=8103
visdom -port $PORT &
EPOCH=01
REM_EPOCH=$((200-$EPOCH))
mkdir ./checkpoints/9_wiki_fine_tune_male/"$EPOCH"_epochs
echo $CUDA_VISIBLE_DEVICES
python train.py --dataroot ../celeba \
    --name 9_wiki_fine_tune_male \
    --model cycle_gan --gpu_ids 0 \
    --display_freq 5 --print_freq 5 \
    --use_pretrained_model \
    --pretrained_model_name 9_wiki_fine_tune_male \
    --pretrained_model_subname G_A,G_B,D_A,D_B \
    --pretrained_model_epoch 200 \
    --epoch_count $REM_EPOCH \
    --display_server localhost \
    --batch_size 8 \
    --save_epoch_freq 200
mv end* ./checkpoints/9_wiki_fine_tune_male/"$EPOCH"_epochs
