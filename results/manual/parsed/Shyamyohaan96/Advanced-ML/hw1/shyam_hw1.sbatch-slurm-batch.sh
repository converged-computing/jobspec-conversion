#!/bin/bash
#SBATCH --job-name=brain_machine_interface
#SBATCH --output=results/brain_machine_exp%04a_stdout.txt
#SBATCH --error=results/brain_machine_exp%04a_stderr.txt
#SBATCH --mail-user=shyamkrishnan@ou.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=1024
#SBATCH --time=01:00:00
#SBATCH --chdir=/home/cs504311/hw1/
#SBATCH --array=0-119

. /home/fagg/tf_setup.sh
conda activate tf
python hw1_shyam.py --epochs 1000 --exp_index $SLURM_ARRAY_TASK_ID
