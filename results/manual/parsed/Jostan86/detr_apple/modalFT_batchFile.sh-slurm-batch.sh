#!/bin/bash
#SBATCH --job-name=modalFT_r101
#SBATCH --output=/nfs/hpc/share/browjost/detr_apple/logdirs/modalFT_r101dc5/modalFineTune-%a.out
#SBATCH --error=/nfs/hpc/share/browjost/detr_apple/logdirs/modalFT_r101dc5/modalFineTune-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --nodelist=dgx2-3

module load python3
source /nfs/hpc/share/browjost/detr_apple/venv/bin/activate
srun --export ALL python3 -m torch.distributed.launch --nproc_per_node=1 --use_env main2.py --coco_path /nfs/hpc/share/browjost/detr_apple/coco_apples/ --batch_size 2 --resume /nfs/hpc/share/browjost/detr_apple/weights/detr-r101-dc5_no-class-head.pth --epochs 50 --output_dir /nfs/hpc/share/browjost/detr_apple/logdirs/modalFT_r101dc5 --dataset_file coco_apples_modal --backbone resnet101 --dilation
