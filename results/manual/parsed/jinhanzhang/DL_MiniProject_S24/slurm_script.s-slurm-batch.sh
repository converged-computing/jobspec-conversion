#!/bin/bash
#SBATCH --job-name=jzfov
#SBATCH --output=output_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=03:59:00
#SBATCH --constraint=ntasks-per-node=1

singularity exec --nv --overlay /scratch/jz5952/dl-env/dl.ext3:ro /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif /bin/bash -c "source /ext3/env.sh && cd project_directory && python3 main.py --model ResNet --epochs 200 --lr 0.1 --batch_size 128 --optimizer Adadelta  --data_augmentation True"
