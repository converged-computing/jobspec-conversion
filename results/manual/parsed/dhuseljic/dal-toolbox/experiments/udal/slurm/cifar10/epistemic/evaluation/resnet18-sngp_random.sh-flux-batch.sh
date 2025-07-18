#!/bin/bash
#FLUX: --job-name=udal
#FLUX: -c=8
#FLUX: --queue=main
#FLUX: --urgency=16

date;hostname;pwd
source ~/envs/dal-toolbox/bin/activate
cd /mnt/home/dhuseljic/projects/dal-toolbox/experiments/udal/
dataset=CIFAR10
ood_datasets=\[CIFAR100,\ SVHN\]
model=resnet18_sngp
al_strat=random
n_init=128
acq_size=128
n_acq=38
random_seed=$SLURM_ARRAY_TASK_ID
queried_indices_json=/mnt/work/dhuseljic/results/udal/active_learning/${dataset}/${model}/${al_strat}/N_INIT${n_init}__ACQ_SIZE${acq_size}__N_ACQ${n_acq}/seed${random_seed}/queried_indices.json
output_dir=/mnt/work/dhuseljic/results/udal/evaluation/${dataset}/${model}_sngp/${al_strat}/N_INIT${n_init}__ACQ_SIZE${acq_size}__N_ACQ${n_acq}/seed${random_seed}/
echo "Starting script. Writing results to ${output_dir}"
srun python -u evaluate.py \
	model=resnet18_sngp \
	dataset=$dataset \
	ood_datasets=$ood_datasets \
	dataset_path=/mnt/work/dhuseljic/datasets \
	queried_indices_json=$queried_indices_json \
	output_dir=$output_dir \
	random_seed=$random_seed 
echo "Finished script."
date
