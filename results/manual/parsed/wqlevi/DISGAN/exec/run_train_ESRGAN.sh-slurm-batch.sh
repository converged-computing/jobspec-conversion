#!/bin/bash
#SBATCH --job-name=TORCH-GPU
#SBATCH --output=./log/c20.out.%j
#SBATCH --error=./log/c20.err.%j
#SBATCH --mail-user=qi.wang@tuebingen.mpg.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:4
#SBATCH --time=1-00:00:00
#SBATCH --constraint=gpu
#SBATCH --chdir=./

module purge 
module load anaconda/3/2020.02
module load cuda/11.2
module load nibabel/2.5.0
module load pytorch/gpu-cuda-11.2/1.8.1
srun python /u/wangqi/git_wq/3d_super-resolution_mri/mains/train_script_resnet10_tsboard.py --path /ptmp/wangqi/transfer_folder/LS200X_Norm/train_crops --model C20 --checkpoint 0 --precision 1 --batch_size 8 --lr .0002 --epoch 50
echo "Jobs finished"
