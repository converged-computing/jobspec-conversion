#!/bin/bash
#FLUX: --job-name=fedavg_cifar10_nclients_niid_labeldir
#FLUX: --queue=gpulong
#FLUX: -t=252000
#FLUX: --urgency=16

ml TensorFlow/2.2.0-fosscuda-2019b-Python-3.7.4
ml matplotlib/3.1.1-fosscuda-2019b-Python-3.7.4
ml SciPy-bundle/2019.10-fosscuda-2019b-Python-3.7.4
ml PyTorch/1.8.0-fosscuda-2019b-Python-3.7.4
ml torchvision/0.9.1-fosscuda-2019b-PyTorch-1.8.0
ml scikit-learn/0.21.3-fosscuda-2019b-Python-3.7.4
for epoch in 1
do
    for clients in 500
    do
        dir='../save_results/fedavg/cifar10'
        if [ ! -e $dir ]; then
        mkdir -p $dir
        fi
        python ../main.py \
        --ntrials=1 \
        --rounds=100 \
        --num_users=$clients \
        --frac=0.03 \
        --local_ep=$epoch \
        --local_bs=10 \
        --lr=0.01 \
        --momentum=0.9 \
        --model=lenet5 \
        --dataset=cifar10 \
        --partition='niid-labeldir' \
        --datadir='../../data/' \
        --logdir='../results_num_clients/adjusted_frac/' \
        --log_filename='epoch_'$epoch'_clients_'$clients \
        --alg='fedavg' \
        --iid_beta=0.5 \
        --niid_beta=0.15 \
        --local_view \
        --noise=0 \
        --gpu=0 \
        --print_freq=10
    done
done
