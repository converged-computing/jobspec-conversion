#!/bin/bash
#SBATCH --job-name=lg_cifar10_superclass_1
#SBATCH --output=results/lg_cifar10_superclass_1.out
#SBATCH --error=results/lg_cifar10_superclass_1.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=50G
#SBATCH --time=2-22:00:00
#SBATCH --partition=gpulong
#SBATCH --constraint=ntasks-per-node=1

ml TensorFlow/2.2.0-fosscuda-2019b-Python-3.7.4
ml matplotlib/3.1.1-fosscuda-2019b-Python-3.7.4
ml SciPy-bundle/2019.10-fosscuda-2019b-Python-3.7.4
ml PyTorch/1.8.0-fosscuda-2019b-Python-3.7.4
ml torchvision/0.9.1-fosscuda-2019b-PyTorch-1.8.0
ml scikit-learn/0.21.3-fosscuda-2019b-Python-3.7.4
for trial in 1
do  
    python ../main.py \
    --ntrials=3 \
    --rounds=50 \
    --num_users=25 \
    --frac=0.3 \
    --local_ep=10 \
    --local_bs=10 \
    --lr=0.01 \
    --momentum=0.5 \
    --model=resnet9 \
    --dataset=stl10 \
    --partition='sc_niid_dir' \
    --datadir='../../data/' \
    --logdir='../save_results/' \
    --log_filename=$trial \
    --alg='lg' \
    --beta=0.5 \
    --local_view \
    --noise=0 \
    --gpu=0 \
    --print_freq=10
done 
