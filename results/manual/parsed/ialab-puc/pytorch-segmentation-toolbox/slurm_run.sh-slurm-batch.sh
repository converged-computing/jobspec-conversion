#!/bin/bash
#SBATCH --job-name=pspCityscapes
#SBATCH --output=output/psp_%j.log
#SBATCH --error=output/err/psp_%j.err
#SBATCH --mail-user=afcadiz@uc.cl
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:4
#SBATCH --mem=12000mb
#SBATCH --time=02:00:00
#SBATCH --partition=ialab-high
#SBATCH --nodelist=hydra

CS_PATH=$1
MODEL=pspnet
LR=1e-2
WD=5e-4
BS=8
STEPS=40000
GPU_IDS=0
python -m torch.distributed.launch --nproc_per_node=4 train.py --data-dir ${CS_PATH} --model ${MODEL} --random-mirror --random-scale --learning-rate ${LR}  --weight-decay ${WD} --batch-size ${BS} --num-steps ${STEPS} --restore-from ./dataset/MS_DeepLab_resnet_pretrained_init.pth --gpu ${GPU_IDS}
