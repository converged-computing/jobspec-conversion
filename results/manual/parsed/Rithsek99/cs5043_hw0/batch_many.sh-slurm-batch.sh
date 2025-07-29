#!/bin/bash
#SBATCH --job-name=hw0_test
#SBATCH --output=results/hw0_exp%04a_stdout.txt
#SBATCH --error=results/hw0_exp%04a_stderr.txt
#SBATCH --mail-user=rithsek.ngem-1@ou.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1024
#SBATCH --time=00:02:00
#SBATCH --partition=debug_5min
#SBATCH --chdir=/home/cs504312/cs5043/hw/hw_0
#SBATCH --array=0-9

. /home/fagg/tf_setup.sh
conda activate tf
python hw_0.py --epochs 7000 --hidden 16 --exp $SLURM_ARRAY_TASK_ID
