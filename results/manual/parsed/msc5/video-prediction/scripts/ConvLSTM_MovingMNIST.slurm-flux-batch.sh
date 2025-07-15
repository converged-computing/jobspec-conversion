#!/bin/bash
#FLUX: --job-name=vp_mmnist
#FLUX: -c=4
#FLUX: -t=43200
#FLUX: --urgency=16

CWD_PATH=$(pwd)
SCRIPT_PATH=$(dirname $(readlink -f "$0"))
echo "Executing on the machine  	$HOSTNAME"
echo "Current Working Directory 	$CWD_PATH"
echo "Slurm Script Directory    	$SCRIPT_PATH"
echo "SLURM_ARRAY_JOB_ID is     	$SLURM_ARRAY_JOB_ID"
echo "SLURM_ARRAY_TASK_ID is    	$SLURM_ARRAY_TASK_ID"
module purge
module load anaconda3/2021.5
conda activate torch-env
python -m src train ConvLSTM MovingMNIST \
	--task_id $SLURM_ARRAY_TASK_ID \
	--num_layers $SLURM_ARRAY_TASK_ID \
	--max_epochs 10 \
	--mmnist_num_digits 2
