#!/bin/bash
#SBATCH --job-name=novel
#SBATCH --output=logs/R-%x.%j.out
#SBATCH --error=logs/R-%x.%j.err
#SBATCH --mail-user=****
#SBATCH --mail-type=fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=300M
#SBATCH --time=03:02:00
#SBATCH --array=0-99

module purge
module load anaconda3/2021.5
python main.py $SLURM_ARRAY_TASK_ID 0 100 2000
