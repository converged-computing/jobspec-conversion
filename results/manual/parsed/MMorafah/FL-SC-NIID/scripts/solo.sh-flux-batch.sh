#!/bin/bash
#FLUX: --job-name=solo_cifar10_superclass_1
#FLUX: --queue=gpulong
#FLUX: -t=252000
#FLUX: --priority=16

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
    --rounds=10 \
    --num_users=100 \
    --frac=1.0 \
    --local_ep=10 \
    --local_bs=10 \
    --lr=0.01 \
    --momentum=0.5 \
    --model=simple-cnn \
    --dataset=cifar10 \
    --partition='sc_old_niid2' \
    --datadir='../../data/' \
    --logdir='../save_results/' \
    --log_filename=$trial \
    --alg='solo' \
    --beta=0.5 \
    --local_view \
    --noise=0 \
    --gpu=0 \
    --print_freq=10
done 
