#!/bin/bash
#FLUX: --job-name=spicy-underoos-7741
#FLUX: -c=10
#FLUX: -t=86400
#FLUX: --urgency=16

module load python/3.6
module load cuda cudnn 
source ~/PPOC_gpu/bin/activate
python ./baselines/ppo1/run_mujoco.py --saves --opt=4 --minibatch=200 --dc=0.1 --tradeoff=0.01 --prew_control=1e3 --caption='' --diayn --seed=11
