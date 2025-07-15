#!/bin/bash
#FLUX: --job-name=alg_feddf_cifar100
#FLUX: --queue=gpulong
#FLUX: -t=252000
#FLUX: --urgency=16

ml TensorFlow/2.2.0-fosscuda-2019b-Python-3.7.4
ml matplotlib/3.1.1-fosscuda-2019b-Python-3.7.4
ml SciPy-bundle/2019.10-fosscuda-2019b-Python-3.7.4
ml PyTorch/1.8.0-fosscuda-2019b-Python-3.7.4
ml torchvision/0.9.1-fosscuda-2019b-PyTorch-1.8.0
ml scikit-learn/0.21.3-fosscuda-2019b-Python-3.7.4
for alg in feddf
do
    python ../main.py \
    --ntrials=3 \
    --rounds=100 \
    --num_users=100 \
    --frac=0.1 \
    --local_ep=5 \
    --local_bs=10 \
    --lr=0.01 \
    --momentum=0.9 \
    --model=lenet5 \
    --dataset=cifar10 \
    --partition='niid-labelskew' \
    --datadir='../../data/' \
    --logdir='../results_performance_comp/' \
    --log_filename='lenet5_E10_C0.1_sgd_0.01_5eKL_T3' \
    --alg=$alg \
    --iid_beta=0.5 \
    --niid_beta=8 \
    --distill_T=3 \
    --distill_E=5 \
    --distill_lr=0.00001 \
    --public_dataset='cifar100'\
    --gpu=0 \
    --print_freq=10
done 
