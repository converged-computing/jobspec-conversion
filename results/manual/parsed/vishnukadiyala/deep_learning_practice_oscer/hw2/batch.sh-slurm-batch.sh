#!/bin/bash
#SBATCH --job-name=hw2_run2
#SBATCH --output=results/r2/hw2_%j_stdout.txt
#SBATCH --error=results/r2/hw2_%j_stderr.txt
#SBATCH --mail-user=vishnupk@ou.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=2048
#SBATCH --time=00:30:00
#SBATCH --partition=normal
#SBATCH --chdir=/home/cs504305/deep_learning_practice/homework/hw2
#SBATCH --array=0-160

. /home/fagg/tf_setup.sh
conda activate tf
python hw1_base.py --hidden 400 200 100 50 25 12 --activation_out linear --epochs 1000 --results_path ./results/r2 --exp_index $SLURM_ARRAY_TASK_ID --output_type ddtheta --predict_dim 1 --cpus_per_task $SLURM_CPUS_PER_TASK
