#!/bin/bash
#FLUX: --job-name=modalFineTune
#FLUX: --queue=dgx
#FLUX: --urgency=16

module load python3
source /nfs/hpc/share/browjost/detr_apple/venv/bin/activate
srun --export ALL python3 -m torch.distributed.launch --nproc_per_node=2 --use_env main2.py --coco_path /nfs/hpc/share/browjost/detr_apple/coco_apples_synth/ --batch_size 2 --resume /nfs/hpc/share/browjost/detr_apple/weights/detr-r50_no-class-head.pth --epochs 50 --output_dir /nfs/hpc/share/browjost/detr_apple/logdirs/modalFT_sy --dataset_file coco_apples_modal_synth
