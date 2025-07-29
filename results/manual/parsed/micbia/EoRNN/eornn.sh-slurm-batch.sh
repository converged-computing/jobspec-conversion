#!/bin/bash
#SBATCH --account=hpo22
#SBATCH --output=./outputs/output_eornn_gpu4.%j
#SBATCH --error=./errors/error_eornn_gpu4.%j
#SBATCH --nodes=4
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=12

module load Python
module load scikit
module load Keras
module load TensorFlow
module load CUDA
python TrainingEoRNN.py
