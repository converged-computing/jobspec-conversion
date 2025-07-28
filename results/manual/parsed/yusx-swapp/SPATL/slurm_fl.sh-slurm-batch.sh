#!/bin/bash
#FLUX: --job-name=multi-head fl
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=151200
#FLUX: --urgency=16

cd /work/LAS/jannesar-lab/yusx/MHFL
source /work/LAS/jannesar-lab/yusx/anaconda3/bin/activate /work/LAS/jannesar-lab/yusx/anaconda3/envs/mhfl
nvidia-smi
python spatl_federated_learning.py \
--model=resnet20 \
--dataset=cifar10 \
--alg=spatl \
--lr=0.01 \
--batch-size=64 \
--epochs=10 \
--n_parties=100 \
--beta=0.1 \
--device='cuda' \
--datadir='./data/' \
--logdir='./logs/'  \
--noise=0 \
--sample=0.4 \
--rho=0.9 \
--partition=noniid-labeldir \
--comm_round=500 \
--init_seed=0
'''
python multi_head_federated_learning.py \
--model=resnet20 \
--dataset=cifar10 \
--alg=scaffold \
--lr=0.001 \
--batch-size=64 \
--epochs=10 \
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
python multi_head_federated_learning.py \
--model=resnet32 \
--dataset=cifar10 \
--alg=scaffold \
--lr=0.0005 \
--batch-size=64 \
--epochs=5 \
--n_parties=50 \
--beta=0.1 \
--device='cuda' \
--datadir='./data/' \
--logdir='./logs/'  \
--noise=0 \
--sample=0.7 \
--rho=0.9 \
--comm_round=200 \
--init_seed=0
'''
