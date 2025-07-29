#!/bin/bash
#SBATCH --job-name=remote_SAM
#SBATCH --output=log/%x_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=40G
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu

module load anaconda3/2022.10/gcc-11.2.0
module load cuda/10.2.89/intel-19.0.3.199
module load parmetis/4.0.3/intel-19.0.3.199-intel-mpi-int32-real64
source activate remote2
nvidia-smi
python src/train.py --split_path split3 --ndwi True
