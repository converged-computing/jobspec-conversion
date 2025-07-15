#!/bin/bash
#FLUX: --job-name=phat-peanut-butter-5391
#FLUX: --urgency=16

module load python3
source /nfs/hpc/share/browjost/detr_apple/venv_amodal/bin/activate
srun --export ALL python3 -m torch.distributed.launch --nproc_per_node=2 --use_env main2.py --masks --lr_drop 15 --coco_path /nfs/hpc/share/browjost/detr_apple/coco_apples/ --batch_size 2 --epochs 25 --output_dir /nfs/hpc/share/browjost/detr_apple/logdirs/amodalSeg --dataset_file coco_apples_amodal --frozen_weights /nfs/hpc/share/browjost/detr_apple/logdirs/amodalFT/checkpoint.pth
