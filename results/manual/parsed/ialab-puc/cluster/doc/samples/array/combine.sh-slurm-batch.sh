#!/bin/bash
#SBATCH --job-name=combine_random
#SBATCH --output=output.log
#SBATCH --mail-user=usuario@uc.cl
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1gb
#SBATCH --time=00:05:00

pwd; hostname; date
python3 /user/slurm/samples/array/combine.py $SLURM_ARRAY_TASK_ID
date
