#!/bin/bash
#FLUX: --job-name=suprem
#FLUX: --priority=16

module load mamba/latest
source activate suprem
RANDOM_PORT=$((RANDOM % 64512 + 1024))
datapath=/scratch/zzhou82/data/Totalsegmentator_dataset/Totalsegmentator_dataset/ 
arch=swinunetr 
target_task=vertebrae
num_target_class=25
num_target_annotation=64
suprem_path=pretrained_weights/supervised_suprem_swinunetr_2100.pth
checkpoint_path=out/efficiency.$arch.$target_task.number$num_target_annotation/model_0.pth
python -W ignore -m torch.distributed.launch --nproc_per_node=1 --master_port=$RANDOM_PORT train.py --dist False --model_backbone $arch --log_name efficiency.$arch.$target_task.number$num_target_annotation --map_type $target_task --num_class $num_target_class --dataset_path $datapath --num_workers 12 --batch_size 8 --pretrain $suprem_path --percent $num_target_annotation
