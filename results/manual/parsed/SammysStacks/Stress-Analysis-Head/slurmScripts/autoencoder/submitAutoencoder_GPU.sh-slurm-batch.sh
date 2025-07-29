#!/bin/bash
#SBATCH --job-name=AutoencoderModel compressionFactor $1 expansionFactor $2
#SBATCH --mail-user=ssolomon@caltech.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:1
#SBATCH --mem=48G
#SBATCH --time=7-00:00:00
#SBATCH --partition=gpu

export PYTORCH_CUDA_ALLOC_CONF='expandable_segments:True'

module load intel-oneapi-mkl/2024.0.0-oneapi-2023.2.1-4aoiyez
module load cuda/11.8.0-gcc-11.3.1-nlhqhb5
module load python/3.10.12-gcc-11.3.1-n4zmj3v   # Load in the latest python version
module load openmpi/5.0.1-gcc-11.3.1-j4o6ryt    # Load in openMPI for cross-node talk
module load cuda/12.2.1-gcc-11.3.1-yfdtcdo      # Load the CUDA module
module load nvhpc/23.7-gcc-11.3.1-gifa6ml
nvcc --version
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True
sh autoencoderTimeAnalysis.sh $1 $2 $3
