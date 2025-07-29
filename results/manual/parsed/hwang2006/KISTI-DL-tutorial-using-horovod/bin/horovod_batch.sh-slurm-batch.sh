#!/bin/bash
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:8
#SBATCH --time=1-00:00:00
#SBATCH --partition=amd_a100nv_8
#SBATCH --constraint=ntasks-per-node=8

module load gcc/10.2.0 cuda/11.4 cudampi/openmpi-4.1.1
source ~/.bashrc
conda activate horovod
srun python tf_keras_fashion_mnist.py
