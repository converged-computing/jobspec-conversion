#!/bin/bash
#FLUX: --job-name=fedavg_cifar10_superclass_1
#FLUX: --queue=gpulong
#FLUX: -t=252000
#FLUX: --urgency=16

ml TensorFlow/2.2.0-fosscuda-2019b-Python-3.7.4
ml matplotlib/3.1.1-fosscuda-2019b-Python-3.7.4
ml SciPy-bundle/2019.10-fosscuda-2019b-Python-3.7.4
ml PyTorch/1.8.0-fosscuda-2019b-Python-3.7.4
ml torchvision/0.9.1-fosscuda-2019b-PyTorch-1.8.0
ml scikit-learn/0.21.3-fosscuda-2019b-Python-3.7.4
for trial in 3
do
    dir='../save_results/fedavg/cifar10'
    if [ ! -e $dir ]; then
    mkdir -p $dir
    fi
    python ../main.py \
    --ntrials=3 \
    --rounds=100 \
    --num_users=100 \
    --frac=0.1 \
    --local_ep=10 \
    --local_bs=10 \
    --lr=0.01 \
    --momentum=0.9 \
    --model=resnet9 \
    --dataset=cifar100 \
    --partition='sc_niid_dir' \
    --datadir='../../data/' \
    --logdir='../save_results/' \
    --log_filename=$trial \
    --alg='fedavg' \
    --beta=0.5 \
    --local_view \
    --noise=0 \
    --gpu=0 \
    --print_freq=10
done 
