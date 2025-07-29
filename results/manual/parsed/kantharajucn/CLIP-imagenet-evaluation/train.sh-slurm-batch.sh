#!/bin/bash
#SBATCH --job-name=Resnet50-train-on-clip
#SBATCH --output=ResNet50-clip%j.out
#SBATCH --error=ResNet50-clip%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:4
#SBATCH --mem=200G
#SBATCH --partition=gpu-2080ti
#SBATCH --constraint=ImageNet2012

scontrol show job $SLURM_JOB_ID
singularity exec --nv --bind /scratch_local/ docker://lukasschott/ifr:v8 python3 train.py /path/to/dataset/ImageNet2012 -a resnet50 --dist-url 'tcp://127.0.0.1:1405' --dist-backend 'nccl' --multiprocessing-distributed --world-size 1 --rank 0 --workers 8  --label-type soft_labels
