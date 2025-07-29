#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:02:00
#SBATCH --array=1-100

spack load python@3.10.8
python ./pi_random.py $SLURM_ARRAY_TASK_ID
