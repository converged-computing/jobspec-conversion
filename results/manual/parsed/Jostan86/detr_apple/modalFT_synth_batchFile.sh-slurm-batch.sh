#!/bin/bash
#SBATCH --job-name=modalFineTune
#SBATCH --output=/nfs/hpc/share/browjost/detr_apple/logdirs/modalFT_sy/modalFineTune-%a.out
#SBATCH --error=/nfs/hpc/share/browjost/detr_apple/logdirs/modalFT_sy/modalFineTune-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --partition=dgx

module load python3
source /nfs/hpc/share/browjost/detr_apple/venv/bin/activate
srun --export ALL python3 -m torch.distributed.launch --nproc_per_node=2 --use_env main2.py --coco_path /nfs/hpc/share/browjost/detr_apple/coco_apples_synth/ --batch_size 2 --resume /nfs/hpc/share/browjost/detr_apple/weights/detr-r50_no-class-head.pth --epochs 50 --output_dir /nfs/hpc/share/browjost/detr_apple/logdirs/modalFT_sy --dataset_file coco_apples_modal_synth
