#!/bin/bash
#SBATCH --job-name=dics
#SBATCH --output=dics.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=03:00:00
#SBATCH --array=0-3756

export OMP_NUM_THREADS='1'

LOG_FILE=logs/dics.log
VERTEX_NUMBER=$(printf "%04d" $SLURM_ARRAY_TASK_ID)
module load anaconda
export OMP_NUM_THREADS=1
srun python ../dics.py -v $SLURM_ARRAY_TASK_ID -n 0.1 2>&1 | sed -e "s/^/$VERTEX_NUMBER:  /" >> $LOG_FILE
