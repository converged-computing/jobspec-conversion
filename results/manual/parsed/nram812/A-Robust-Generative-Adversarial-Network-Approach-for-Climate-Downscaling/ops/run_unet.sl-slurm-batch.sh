#!/bin/bash
#SBATCH --job-name=GPU_job
#SBATCH --account=niwa03712
#SBATCH --output=log/%j-%x.out
#SBATCH --error=log/%j-%x.out
#SBATCH --mail-user=neelesh.rampal@niwa.co.nz
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=256G
#SBATCH --time=2-00:59:00
#SBATCH --partition=hgx

module purge # optional
module load NeSI
module load gcc/9.3.0
module load cuDNN/8.1.1.33-CUDA-11.2.0
nvidia-smi
cd /nesi/project/niwa00018/ML_downscaling_CCAM/training_GAN/
/nesi/project/niwa00004/rampaln/bin/python /nesi/project/niwa00018/ML_downscaling_CCAM/A-Robust-Generative-Adversarial-Network-Approach-for-Climate-Downscaling/train_unet.py $1
