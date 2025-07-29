#!/bin/bash
#SBATCH --job-name=inm705_SR
#SBATCH --output=results/%x_%j.o
#SBATCH --error=results/%x_%j.e
#SBATCH --mail-user=adfx751@city.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=90GB
#SBATCH --time=2-00:00:00
#SBATCH --partition=prigpu
#SBATCH --constraint=ntasks-per-node=1

export WANDB_API_KEY='37d31add06ffd6210d871e1462ad8777b14e5999'
export https_proxy='http://hpc-proxy00.city.ac.uk:3128'

source /opt/flight/etc/setup.sh
flight env activate gridware
module load libs/nvidia-cuda/11.2.0/bin
module load gnu
export WANDB_API_KEY=37d31add06ffd6210d871e1462ad8777b14e5999
echo $WANDB_API_KEY
python --version
nvidia-smi
wandb login $WANDB_API_KEY --relogin
export https_proxy=http://hpc-proxy00.city.ac.uk:3128
python3 train_srgan.py --config configs/SRGAN.yaml
