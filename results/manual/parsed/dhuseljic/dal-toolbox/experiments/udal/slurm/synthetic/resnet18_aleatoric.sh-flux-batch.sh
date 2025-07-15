#!/bin/bash
#FLUX: --job-name=udal_synthetic
#FLUX: -c=8
#FLUX: --queue=main
#FLUX: --priority=16

date;hostname;pwd
source ~/envs/dal-toolbox/bin/activate
cd /mnt/home/dhuseljic/projects/dal-toolbox/experiments/udal/
model=resnet18
dataset_path=/mnt/work/dhuseljic/datasets/pixel_sum_dataset.pth
al_strat=aleatoric
n_init=2
acq_size=2
n_acq=49
random_seed=$SLURM_ARRAY_TASK_ID
output_dir=/mnt/work/dhuseljic/results/udal/synthetic/${model}/${al_strat}/N_INIT${n_init}__ACQ_SIZE${acq_size}__N_ACQ${n_acq}/seed${random_seed}/
echo "Starting script. Writing results to ${output_dir}"
srun python -u synthetic.py \
	model=$model \
	dataset_path=/mnt/work/dhuseljic/datasets/pixel_sum_dataset.pth \
	al_strategy=$al_strat \
	al_cycle.n_init=$n_init \
	al_cycle.acq_size=$acq_size \
	al_cycle.n_acq=$n_acq \
	output_dir=$output_dir \
	random_seed=$random_seed 
echo "Finished script."
date
