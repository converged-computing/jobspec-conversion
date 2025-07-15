#!/bin/bash
#FLUX: --job-name=abdomenatlas1.1-multigpu
#FLUX: --exclusive
#FLUX: --urgency=16

module load mamba/latest # only for Sol
source activate suprem
if [ "$1" = "segresnet" ]; then
    batch_size=16
elif [ "$1" = "unet" ]; then
    batch_size=8
elif [ "$1" = "swinunetr" ]; then
    batch_size=2
fi
nproc_per_node=4
num_workers=$((12 * nproc_per_node))
cache_num=100
RANDOM_PORT=$((RANDOM % 64512 + 1024))
datapath=/scratch/zzhou82/data/AbdomenAtlas1.1Mini
datasetversion=AbdomenAtlas1.1 # or AbdomenAtlas1.0
wordembeddingpath=./pretrained_weights/txt_encoding_abdomenatlas1.1.pth
python -W ignore -m torch.distributed.launch --nproc_per_node=$nproc_per_node --master_port=$RANDOM_PORT train.py --dist  --data_root_path $datapath --dataset_list $datasetversion --num_workers $num_workers --log_name $datasetversion.$1.multigpu --word_embedding $wordembeddingpath --backbone $1 --lr 1e-3 --warmup_epoch 20 --batch_size $batch_size --max_epoch 2000 --cache_dataset --num_class 25 --cache_num $cache_num --dataset_version $datasetversion
