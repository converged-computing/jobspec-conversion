#!/bin/bash
#SBATCH --job-name=TORCH-GPU
#SBATCH --output=./log/c18_l1.out.%j
#SBATCH --error=./log/c18_l1.err.%j
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
srun python ../mains/ESRGAN_WGAN_GP_L1.py --train_path /ptmp/wangqi/transfer_folder/LS200X_Norm/train_crops --model C18_WGANGP_l1_FE --checkpoint 20 --precision 1 --batch_size 4 --lr .0002
echo "Jobs finished"
