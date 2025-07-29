#!/bin/bash
#SBATCH --job-name=MNIST
#SBATCH --output=job_%x_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:v100:1
#SBATCH --time=00:30:00
#SBATCH --partition=gpu_gce

export WCPROJECT='simone'
export CONT_DIR='/wclustre/${WCPROJECT}/containers/'

module load apptainer
export WCPROJECT=simone
export CONT_DIR=/wclustre/${WCPROJECT}/containers/
TORCH=${CONT_DIR}/pytorch-23.02-py3.sif
apptainer exec --home=/work1/${WCPROJECT} --nv ${TORCH} /usr/bin/nvidia-smi
apptainer exec --home=/work1/${WCPROJECT} --nv ${TORCH} /usr/bin/python ./mnist_main.py
