#!/bin/bash
#FLUX: --job-name=lg_mix4_homo_5ep_123
#FLUX: --queue=gpulong
#FLUX: -t=252000
#FLUX: --urgency=16

ml TensorFlow/2.2.0-fosscuda-2019b-Python-3.7.4
ml matplotlib/3.1.1-fosscuda-2019b-Python-3.7.4
ml SciPy-bundle/2019.10-fosscuda-2019b-Python-3.7.4
ml PyTorch/1.8.0-fosscuda-2019b-Python-3.7.4
ml torchvision/0.9.1-fosscuda-2019b-PyTorch-1.8.0
ml scikit-learn/0.21.3-fosscuda-2019b-Python-3.7.4
for trial in 51 52 53
do
    dir='../save_results/lg/homo/mix4'
    if [ ! -e $dir ]; then
    mkdir -p $dir 
    fi 
    python ./main_lg_mix4.py --trial=$trial \
    --rounds=50 \
    --num_users=100 \
    --frac=0.1 \
    --local_ep=5 \
    --local_bs=10 \
    --lr=0.01 \
    --momentum=0.5 \
    --model=simple-cnn \
    --dataset=mix4 \
    --datadir='../../data/' \
    --logdir='../../logs/' \
    --savedir='../save_results/' \
    --partition='homo' \
    --alg='lg' \
    --beta=0.1 \
    --local_view \
    --noise=0 \
    --cluster_alpha=0.3 \
    --nclasses=10 \
    --nsamples_shared=2500 \
    --gpu=0 \
    --print_freq=10 \
    2>&1 | tee $dir'/'$trial'.txt'
done 
