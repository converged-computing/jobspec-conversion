#!/bin/bash
#SBATCH --job-name=hw0
#SBATCH --output=results/hw0_%j_stdout.txt
#SBATCH --error=results/hw0_%j_stderr.txt
#SBATCH --mail-user=vishnupk@ou.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1024
#SBATCH --time=00:02:00
#SBATCH --chdir=/home/cs504305/deep_learning_practice/homework/hw0
#SBATCH --array=0-9

. /home/fagg/tf_setup.sh
conda activate tf
python HW0.py --epochs 500 --hidden 500 --lrate 0.0000001 --activation selu --exp $SLURM_ARRAY_TASK_ID
