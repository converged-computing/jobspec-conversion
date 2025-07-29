#!/bin/bash
#SBATCH --job-name=ImProc_4x
#SBATCH --mail-user=qcaudron@princeton.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4096M
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-999

python batch.py $SLURM_ARRAY_TASK_ID
