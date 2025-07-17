#!/bin/bash
#FLUX: --job-name=hairy-bits-7418
#FLUX: -c=6
#FLUX: --queue=rise
#FLUX: -t=345600
#FLUX: --urgency=16

export PYTHONUNBUFFERED='1'

pwd
hostname
date
echo starting job...
echo celebA dataset and resnet10 with DP-SGD, width 32, weightdecay 1e-4, noise 1.0, max grad norm 1.0, delta 1e-5 with ERM
source ~/.bashrc
source activate sagawa_dp
export PYTHONUNBUFFERED=1
cd /home/eecs/arinchang/overparam_spur_corr
srun -N 1 -n 1 --gres=gpu:1 python run_expt_dp.py -id dp_width32_erm -s confounder -d CelebA --noise 1.0 --max_per_sample_grad_norm 1.0 -t Blond_Hair -c Male --lr 0.01 --batch_size 128 --weight_decay 0.0001 --model resnet10vw --n_epochs 50 --train_from_scratch --resnet_width 32
wait
date
echo "All done"
