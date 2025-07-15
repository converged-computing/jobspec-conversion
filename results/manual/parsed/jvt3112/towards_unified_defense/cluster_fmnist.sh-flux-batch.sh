#!/bin/bash
#FLUX: --job-name=salted-itch-4580
#FLUX: --urgency=16

export PATH='/vol/bitbucket/jvt22/myvenv/bin:$PATH'

export PATH=/vol/bitbucket/jvt22/myvenv/bin:$PATH
source activate
/usr/bin/nvidia-smi
uptime
python main.py --model=cnn --dataset=fmnist --adv=1 --dp=1 --wm=1 --gpu=1 --epochs=50 --num_clients=50 --frac=0.5 --local_ep=5 --local_bs=64 --lr=0.01 --pgd_eps=0.15 --pgd_attack_steps=15 --pgd_step_size=0.01 --dp_epsilon=3 --adv_relax=1 --dp_relax=1
