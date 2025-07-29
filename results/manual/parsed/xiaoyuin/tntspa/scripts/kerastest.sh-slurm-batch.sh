#!/bin/bash
#SBATCH --job-name=kerastest
#SBATCH --account=p_adm
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=10000
#SBATCH --time=02:00:00
#SBATCH --partition=haswell,sandy,west

module purge
module load modenv/eb
module load Keras
module load TensorFlow
srun python mnist_cnn.py
