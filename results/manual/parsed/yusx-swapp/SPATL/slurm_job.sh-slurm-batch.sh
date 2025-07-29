#!/bin/bash
#SBATCH --job-name=multi-head fl
#SBATCH --output=30clients.%J.out
#SBATCH --error=30clients.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=16G
#SBATCH --time=2-08:00:00
#SBATCH --partition=gpu

cd /work/LAS/jannesar-lab/yusx/MHFL
source /work/LAS/jannesar-lab/yusx/anaconda3/bin/activate /work/LAS/jannesar-lab/yusx/anaconda3/envs/mhfl
nvidia-smi
python multi_head_federated_learning.py \
--model=vgg \
--dataset=cifar10 \
--alg=gradient_control \
--lr=0.001 \
--batch-size=64 \
--epochs=5 \
--n_parties=30 \
--beta=0.1 \
--device='cuda' \
--datadir='./data/' \
--logdir='./logs/'  \
--noise=0 \
--sample=0.4 \
--rho=0.9 \
--comm_round=200 \
--init_seed=0
