#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=200000
#SBATCH --time=04:00:00

export MW_NVCC_PATH='/cm/shared/openmind/cuda/9.1/bin'

module add openmind/cuda/9.1
export MW_NVCC_PATH=/cm/shared/openmind/cuda/9.1/bin
module add mit/matlab/2018b
matlab -nodisplay -r "mexGPUall"
