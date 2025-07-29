#!/bin/bash
#SBATCH --job-name=hw2_dropout3
#SBATCH --output=results/dropout3/hw2_%j_stdout.txt
#SBATCH --error=results/dropout3/hw2_%j_stderr.txt
#SBATCH --mail-user=vishnupk@ou.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=1024
#SBATCH --time=00:30:00
#SBATCH --chdir=/home/cs504305/deep_learning_practice/homework/hw2
#SBATCH --array=0-639

. /home/fagg/tf_setup.sh
conda activate tf
python hw1_base_dropout.py --hidden 400 200 100 50 25 12 --activation_out linear --epochs 1000 --results_path ./results/dropout3 --exp_index $SLURM_ARRAY_TASK_ID --output_type ddtheta --predict_dim 1 --cpus_per_task $SLURM_CPUS_PER_TASK 
