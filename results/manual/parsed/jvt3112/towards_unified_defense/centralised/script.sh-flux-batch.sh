#!/bin/bash
#FLUX: --job-name=expensive-eagle-6926
#FLUX: --urgency=16

export PATH='/vol/bitbucket/jvt22/myvenv/bin:$PATH'

export PATH=/vol/bitbucket/jvt22/myvenv/bin:$PATH
source activate
/usr/bin/nvidia-smi
uptime
python main.py --dataset=mnist --model=cnn --wm=1 --dp=0 --adv=0 --adv_relax=1 --dp_relax=1 --dp_epsilon=3 --grad_norm=1.0 --pgd_eps=0.25 --pgd_attack_steps=25 --pgd_step_size=0.01  --epochs=100 --save=0
python main.py --dataset=mnist --model=cnn --wm=0 --dp=0 --adv=1 --adv_relax=1 --dp_relax=1 --dp_epsilon=3 --grad_norm=1.0 --pgd_eps=0.25 --pgd_attack_steps=25 --pgd_step_size=0.01  --epochs=100 --save=0
python main.py --dataset=mnist --model=cnn --wm=0 --dp=1 --adv=0 --adv_relax=1 --dp_relax=1 --dp_epsilon=3 --grad_norm=1.0 --pgd_eps=0.25 --pgd_attack_steps=25 --pgd_step_size=0.01  --epochs=100 --save=0
