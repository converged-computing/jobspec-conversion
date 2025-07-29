#!/bin/bash
#SBATCH --job-name=FLJob
#SBATCH --output=/home/tangm_lab/cse12011439/codes/FLlab.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --constraint=ntasks-per-node=6

python experiments1.py --model=resnet \
	--dataset=cifar10 \
	--alg=fednova \
	--lr=0.01 \
	--batch-size=64 \
	--epochs=10 \
	--n_parties=5 \
	--rho=0.9 \
	--comm_round=50 \
	--partition=noniid-labeldir \
	--beta=0.5\
	--device='cuda:0'\
	--datadir='./data/' \
	--logdir='./logs/' \
	--noise=0\
	--init_seed=0
