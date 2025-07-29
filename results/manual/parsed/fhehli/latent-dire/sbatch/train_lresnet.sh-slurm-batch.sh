#!/bin/bash
#SBATCH --job-name=train
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=a100-pcie-40gb:1
#SBATCH --mem=4G
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=8

module load gcc/8.2.0 python_gpu/3.10.4 eth_proxy
pip install . src/guided-diffusion
DATA="$HOME/Latent-DIRE/data/data"
NAME="LDIRE-10k L-ResNet50"
MODEL="resnet50_latent"
python src/training.py --model $MODEL --name $NAME --data_dir $DATA --batch_size 256 --max_epochs 1000
