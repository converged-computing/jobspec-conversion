#!/bin/bash
#SBATCH --job-name=TORCH-GPU
#SBATCH --output=./log/pipe.out.%j
#SBATCH --error=./log/pipe.err.%j
#SBATCH --mail-user=qi.wang@tuebingen.mpg.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=20000
#SBATCH --time=1-00:00:00
#SBATCH --constraint=gpu
#SBATCH --chdir=./

module purge 
module load anaconda/3/2020.02
module load cuda/11.2
module load nibabel/2.5.0
module load pytorch/gpu-cuda-11.2/1.8.1
echo "This script aims to crop original -> generate SR -> assemble generated SR"
cd /u/wangqi/git_wq/3d_super-resolution_mri/mains/inference
srun python /u/wangqi/git_wq/3d_super-resolution_mri/mains/inference/inference.py --CkpName instancenoise --epoch 39 --RootPath /ptmp/wangqi/saved_models --hr_path /ptmp/wangqi/transfer_folder/LS200X_Norm/LS2009_demean.nii.gz --save_nii 1
echo "Jobs finished"
