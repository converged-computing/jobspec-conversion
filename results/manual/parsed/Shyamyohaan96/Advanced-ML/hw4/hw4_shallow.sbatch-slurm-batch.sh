#!/bin/bash
#SBATCH --job-name=rnn_cnn_proteins_deep
#SBATCH --output=results1/rnn_cnn_proteins%04a_stdout.txt
#SBATCH --error=results1/rnn_cnn_proteins%04a_stderr.txt
#SBATCH --mail-user=shyamkrishnan@ou.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=20G
#SBATCH --time=1-00:00:00
#SBATCH --partition=normal
#SBATCH --chdir=/home/cs504311/hw_6/
#SBATCH --array=0-4

. /home/fagg/tf_setup.sh
conda activate tf
python hw6_shyam.py @deep.txt @exp_1.txt --name 'deep' --rotation $SLURM_ARRAY_TASK_ID
