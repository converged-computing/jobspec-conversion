#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --time=10:00:00
#SBATCH --partition=plgrid-gpu

module purge
module load plgrid/tools/python-intel
module load plgrid/apps/cuda
THEANO_FLAGS='device=gpu,floatX=float32,lib.cnmem=1.0' python -m optimizer_genetic.py
