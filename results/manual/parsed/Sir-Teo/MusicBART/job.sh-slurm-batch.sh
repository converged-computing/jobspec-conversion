#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:2
#SBATCH --mem=64GB
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1

singularity exec --nv \
  --overlay /scratch/wz1492/overlay-25GB-500K.ext3:ro \
  /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif \
  /bin/bash -c "source /scratch/wz1492/env.sh;"
torchrun --nproc_per_node=2 main_parallel.py --model_name bart --epochs 10 --batch_size 6 --learning_rate 1e-5
