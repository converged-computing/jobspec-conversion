#!/bin/bash
#SBATCH --output=output.%j.test.out
#SBATCH --mail-user=qfeng10@sheffield.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=6G
#SBATCH --qos=gpu

module load Anaconda3/2022.10
module load cuDNN/8.0.4.30-CUDA-11.1.1
source activate torch2
python train.py
