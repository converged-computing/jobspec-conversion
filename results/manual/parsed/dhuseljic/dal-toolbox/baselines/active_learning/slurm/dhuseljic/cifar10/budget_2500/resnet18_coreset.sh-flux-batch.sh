#!/bin/bash
#FLUX: --job-name=al_baselines
#FLUX: -c=8
#FLUX: --queue=main
#FLUX: --urgency=16

date;hostname;pwd
source activate dal-toolbox
cd ~/projects/dal-toolbox/experiments/active_learning/
model=resnet18
dataset=CIFAR10
al_strat=coreset
n_init=250
acq_size=250
n_acq=9
budget=$((n_init + n_acq * acq_size))
random_seed=$SLURM_ARRAY_TASK_ID
output_dir=/mnt/work/deep_al/results/al_baselines/${dataset}/${model}/${al_strat}/budget_${budget}/seed${random_seed}/
srun python -u active_learning.py \
	model=$model \
	model.optimizer.lr=1e-3 \
	model.optimizer.weight_decay=5e-2 \
	dataset=$dataset \
	dataset_path=/mnt/work/dhuseljic/datasets \
	al_strategy=$al_strat \
	al_cycle.n_init=$n_init \
	al_cycle.acq_size=$acq_size \
	al_cycle.n_acq=$n_acq \
	random_seed=$random_seed \
	output_dir=$output_dir
