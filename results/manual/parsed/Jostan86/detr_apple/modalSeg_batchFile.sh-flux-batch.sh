#!/bin/bash
#FLUX: --job-name=sticky-fork-3087
#FLUX: --priority=16

module load python3
source /nfs/hpc/share/browjost/detr_apple/venv/bin/activate
srun --export ALL python3 -m torch.distributed.launch --nproc_per_node=2 --use_env main2.py --masks --lr_drop 15 --coco_path /nfs/hpc/share/browjost/detr_apple/coco_apples/ --batch_size 2 --epochs 25 --output_dir /nfs/hpc/share/browjost/detr_apple/logdirs/modalSeg --dataset_file coco_apples_modal --frozen_weights /nfs/hpc/share/browjost/detr_apple/logdirs/modalFT/checkpoint.pth
