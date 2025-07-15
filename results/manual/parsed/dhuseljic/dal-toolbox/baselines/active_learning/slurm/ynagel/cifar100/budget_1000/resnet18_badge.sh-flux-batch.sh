#!/bin/bash
#FLUX: --job-name=al_baselines
#FLUX: -c=8
#FLUX: --queue=main
#FLUX: --urgency=16

date;hostname;pwd
source /mnt/stud/home/ynagel/dal-toolbox/venv/bin/activate
cd ~/dal-toolbox/experiments/active_learning/
model=resnet18
dataset=CIFAR100
al_strat=badge
n_init=100
acq_size=100
n_acq=9
budget=$((n_init + n_acq * acq_size))
random_seed=$SLURM_ARRAY_TASK_ID
output_dir=/mnt/stud/home/ynagel/dal-toolbox/results/al_baselines/${dataset}/${model}/${al_strat}/budget_${budget}/seed${random_seed}/
srun python -u active_learning.py \
	model=$model \
	model.optimizer.lr=1e-3 \
	model.optimizer.weight_decay=5e-2 \
	dataset=$dataset \
	dataset_path=/mnt/stud/home/ynagel/data \
	al_strategy=$al_strat \
	al_cycle.n_init=$n_init \
	al_cycle.acq_size=$acq_size \
	al_cycle.n_acq=$n_acq \
	random_seed=$random_seed \
	output_dir=$output_dir
