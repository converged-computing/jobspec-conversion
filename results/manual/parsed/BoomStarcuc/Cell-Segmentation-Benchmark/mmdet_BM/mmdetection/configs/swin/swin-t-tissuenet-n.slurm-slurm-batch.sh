#!/bin/bash
#SBATCH --job-name=swin-t-tissuenet-n-1C
#SBATCH --account=sada-cnmi
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:4
#SBATCH --mem=200G
#SBATCH --time=3-00:00:00

spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw
cd mmdetection
nvidia-smi
sh mmdetection/tools/dist_train.sh mmdetection/configs/swin/mask_rcnn_swin-t-p4-w7_fpn_ms-crop-50e_coco_tissuenet_n.py 4 --work-dir /shared/rc/spl/mmdet_output/All_to_all/nuclear_oc/swin-t-p4-w7_fpn_ms-crop-50e_coco_tissuenet_n
