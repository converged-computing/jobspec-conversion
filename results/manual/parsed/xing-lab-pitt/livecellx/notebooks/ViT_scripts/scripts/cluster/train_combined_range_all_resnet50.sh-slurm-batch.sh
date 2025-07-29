#!/bin/bash
#SBATCH --job-name=train_csn
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=40G
#SBATCH --partition=dept_gpu
#SBATCH --exclude=g019,g102,g104,g122,g012,g013,g131,g011

echo
echo $SLURM_JOB_NODELIST
echo
nvidia-smi -L
python=/net/capricorn/home/xing/ken67/.conda/envs/livecell-tracker/bin/python
python train_classify_ViT_classifier_v14_lightning.py\
    --batch_size=32\
    --frame-type combined\
    --model_version "resnet50-frame_all-combined"\
    --model resnet50\
    --max-epochs 100\
