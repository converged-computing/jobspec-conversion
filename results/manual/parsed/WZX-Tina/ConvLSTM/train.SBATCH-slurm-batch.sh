#!/bin/bash
#SBATCH --job-name=train
#SBATCH --output=train.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=100GB
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
singularity exec --nv --overlay /scratch/tw2672/pytorch/torch2cuda8.ext3:ro  /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif  /bin/bash -c 'source /ext3/env.sh;python main.py'
