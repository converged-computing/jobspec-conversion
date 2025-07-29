#!/bin/bash
#SBATCH --job-name=xu
#SBATCH --account=Project_2002243
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:a100:1,nvme:180
#SBATCH --mem=4G
#SBATCH --time=01:00:00

$SCRATCH
module load pytorch/1.10
srun nvidia-smi
python ./adapt_da.py --model ResNet10 --train_aug --use_saved --dtarget CropDisease --n_shot 1
