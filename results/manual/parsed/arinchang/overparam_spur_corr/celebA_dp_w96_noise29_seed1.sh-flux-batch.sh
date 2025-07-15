#!/bin/bash
#FLUX: --job-name=boopy-house-8530
#FLUX: -c=6
#FLUX: --urgency=16

export PYTHONUNBUFFERED='1'

pwd
hostname
date
echo starting job...
echo celebA dataset and resnet10 with DP-SGD, width 96, weightdecay 1e-4, noise_mult 2.9, max grad norm 1.0, delta 1e-5.
echo yes --reweight_groups
echo random seed 1
source ~/.bashrc
source activate sagawa_dp
export PYTHONUNBUFFERED=1
cd /home/eecs/arinchang/overparam_spur_corr
srun -N 1 -n 1 --gres=gpu:1 python run_expt_dp.py -id dp_w96_n29_reweight_seed1 -s confounder --random_seed 1 -d CelebA --noise 2.9 --max_per_sample_grad_norm 1.0 -t Blond_Hair -c Male --lr 0.01 --batch_size 128 --weight_decay 0.0001 --model resnet10vw --n_epochs 50 --reweight_groups --train_from_scratch --resnet_width 96
wait
date
echo "All done"
