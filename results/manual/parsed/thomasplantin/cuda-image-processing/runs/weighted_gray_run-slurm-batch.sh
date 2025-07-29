#!/bin/bash
#SBATCH --job-name=a
#SBATCH --account=EE-382C-EE-361C-Mult
#SBATCH --output=a.res%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00
#SBATCH --partition=gtx

module load cuda
module load gcc/7.3.0
cuda-memcheck ./a.out images/lena_rgb.png output_images/grayscale_weighted_lena.png grayweight single
