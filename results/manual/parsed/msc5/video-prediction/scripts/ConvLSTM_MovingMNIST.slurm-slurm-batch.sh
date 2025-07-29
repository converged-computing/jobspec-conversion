#!/bin/bash
#SBATCH --job-name=vp_mmnist
#SBATCH --mail-user=msc5@princeton.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=4G
#SBATCH --time=12:00:00
#SBATCH --chdir=/scratch/network/msc5/code/junior-iw/
#SBATCH --array=4,5

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
