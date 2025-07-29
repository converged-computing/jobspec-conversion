#!/bin/bash
#SBATCH --job-name=hybrid
#SBATCH --account=def-raymond
#SBATCH --output=data/%x-%j.out
#SBATCH --mail-user=mvasmer@pitp.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=1-00:00:00
#SBATCH --array=0-59

pwd
echo "SLURM_JOB_ID=$SLURM_JOB_ID"
date
module load python 
module load scipy-stack
file="input/04_09_20d.csv"
line=$SLURM_ARRAY_TASK_ID
python monte_carlo.py $file $line $line
date
