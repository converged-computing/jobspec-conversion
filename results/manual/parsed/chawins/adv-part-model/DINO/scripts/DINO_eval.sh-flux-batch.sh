#!/bin/bash
#FLUX: --job-name=part-model
#FLUX: -n=2
#FLUX: --queue=savio2_1080ti
#FLUX: -t=86400
#FLUX: --priority=16

module purge
source activate /global/scratch/users/$USER/env_part_based
module load cuda/10.2
module load gcc/6.4.0 
python main_debug.py
cd /global/home/users/nabeel126/adv-part-model/DINO/models/dino/ops/
bash make.sh
cd /global/home/users/nabeel126/adv-part-model/DINO/
ID=8
GPU=0
NUM_GPU=1
PORT=1000$ID
coco_path=/global/scratch/users/nabeel126/coco/
checkpoint=/global/scratch/users/nabeel126/adv-part-model/DINO/DINO_pretrained_models/checkpoint0011_4scale.pth
echo "Starting Evaluation"
torchrun \
    --standalone --nnodes=1 --max_restarts 0 --nproc_per_node=$NUM_GPU \
	main.py \
	--output_dir logs/DINO/R50-MS4-%j \
	-c config/DINO/DINO_4scale.py --coco_path $coco_path  \
	--eval --resume $checkpoint \
	--options dn_scalar=100 embed_init_tgt=TRUE \
	dn_label_coef=1.0 dn_bbox_coef=1.0 use_ema=False \
	dn_box_noise_scale=1.0 
