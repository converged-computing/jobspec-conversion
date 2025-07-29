#!/bin/bash
#SBATCH --job-name=hw1_run4
#SBATCH --output=results/r1/hw1_%j_stdout.txt
#SBATCH --error=results/r1/hw1_%j_stderr.txt
#SBATCH --mail-user=vishnupk@ou.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1024
#SBATCH --time=00:30:00
#SBATCH --partition=normal
#SBATCH --chdir=/home/cs504305/deep_learning_practice/homework/hw1
#SBATCH --array=0-160

. /home/fagg/tf_setup.sh
conda activate tf
python hw1_base.py --hidden 1000 --activation_out linear --epochs 1000 --results_path ./results/r1 --exp_index $SLURM_ARRAY_TASK_ID --output_type ddtheta --predict_dim 0
