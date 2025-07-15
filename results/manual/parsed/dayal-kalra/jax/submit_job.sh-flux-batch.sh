#!/bin/bash
#FLUX: --job-name=_warmup
#FLUX: --queue=gpu
#FLUX: -t=43200
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
srun time python3 train_wide_resnet_linear_warmup.py --dataset cifar10 --loss_name xent --abc sp --width 16 --widening_factor 4 --depth 16 --scale 0.0 --varw 2.0 --act relu --lr_exp_start 5.50 --warm_steps 512 --num_epochs 200 --init_seed 1 --momentum 0.0 --augment False  
