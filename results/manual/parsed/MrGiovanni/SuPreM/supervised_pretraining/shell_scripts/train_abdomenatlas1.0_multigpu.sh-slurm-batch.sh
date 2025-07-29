#!/bin/bash
#SBATCH --job-name=abdomenatlas1.0-multigpu
#SBATCH --output=%x_slurm_%j.out
#SBATCH --error=%xslurm_%j.err
#SBATCH --mail-user=zzhou82@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=0
#SBATCH --time=7-00:00:00
#SBATCH --partition=public
#SBATCH: --exclusive

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
datapath=/scratch/zzhou82/data/AbdomenAtlas1.0Mini
datasetversion=AbdomenAtlas1.0 # or AbdomenAtlas1.0
wordembeddingpath=./pretrained_weights/txt_encoding_abdomenatlas1.0.pth # for AbdomenAtlas 1.0
python -W ignore -m torch.distributed.launch --nproc_per_node=$nproc_per_node --master_port=$RANDOM_PORT train.py --dist --data_root_path $datapath --dataset_list $datasetversion --num_workers $num_workers --log_name $datasetversion.$1.multigpu --word_embedding $wordembeddingpath --backbone $1 --lr 1e-3 --warmup_epoch 20 --batch_size $batch_size --max_epoch 2000 --cache_dataset --num_class 9 --cache_num $cache_num --dataset_version $datasetversion
