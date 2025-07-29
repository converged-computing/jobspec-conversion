#!/bin/bash
#SBATCH --job-name=evaluate
#SBATCH --account=<accountname>
#SBATCH --output=logs/evaluate.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:0
#SBATCH --mem=128000M
#SBATCH --time=00:24:00
#SBATCH --qos=1

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
dataset=$1
predictor=$2
n_seeds=$3
n_train=$4
n_threads=16
kwargs=$5
python src/evaluate.py $dataset $predictor \
	--n_threads=$n_threads --n_seeds=$n_seeds \
	--n_train=$n_train --joint_training $kwargs
