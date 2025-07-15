#!/bin/bash
#FLUX: --job-name=udal
#FLUX: -c=8
#FLUX: --queue=main
#FLUX: --urgency=16

date;hostname;pwd
source /mnt/stud/home/ynagel/dal-toolbox/venv/bin/activate
cd /mnt/stud/home/ynagel/dal-toolbox/experiments/udal/
dataset=IMAGENET100
ood_datasets=\[CIFAR10,\ CIFAR100\]
model=resnet18_mcdropout
al_strat=random
n_init=2048
acq_size=2048
n_acq=9
random_seed=$SLURM_ARRAY_TASK_ID
queried_indices_json=/mnt/stud/work/ynagel/results/udal/active_learning/${dataset}/${model}/${al_strat}/N_INIT${n_init}__ACQ_SIZE${acq_size}__N_ACQ${n_acq}/seed${random_seed}/queried_indices.json
output_dir=/mnt/stud/work/ynagel/results/udal/evaluation/${dataset}/${model}_sngp/${al_strat}/N_INIT${n_init}__ACQ_SIZE${acq_size}__N_ACQ${n_acq}/seed${random_seed}/
echo "Starting script. Writing results to ${output_dir}"
srun python -u evaluate.py \
	model=resnet18_sngp \
	dataset=$dataset \
    ood_datasets=$ood_datasets \
	dataset_path=/mnt/datasets/imagenet/ILSVRC2012/ \
	queried_indices_json=$queried_indices_json \
	output_dir=$output_dir \
	random_seed=$random_seed 
echo "Finished script."
date
