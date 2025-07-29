#!/bin/bash
#SBATCH --job-name=image_classification
#SBATCH --output=results/image_classification_exp%04a_stdout.txt
#SBATCH --error=results/image_classification_exp%04a_stderr.txt
#SBATCH --mail-user=shyamkrishnan@ou.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=10G
#SBATCH --time=12:00:00
#SBATCH --chdir=/home/cs504311/hw3/
#SBATCH --array=0-4

. /home/fagg/tf_setup.sh
conda activate tf
python hw3_shyam.py @deep.txt @exp.txt --rotation $SLURM_ARRAY_TASK_ID
