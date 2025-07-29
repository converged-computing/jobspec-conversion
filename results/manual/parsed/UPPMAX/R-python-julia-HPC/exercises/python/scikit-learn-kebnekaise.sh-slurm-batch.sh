#!/bin/bash
#SBATCH --account=hpc2n2024-025
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --time=00:05:00

module purge  > /dev/null 2>&1
module load GCC/10.3.0  OpenMPI/4.1.1 TensorFlow/2.6.0-CUDA-11.3.1
source scikit-venv/bin/activate
python scikit-learn-kebnekaise.py
