#!/bin/bash
#SBATCH --job-name=rdkitconf
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=kemi1
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-34

WIDTH=1000
TMP=`expr $SLURM_ARRAY_TASK_ID - 1`
TMP2=`expr $TMP \* $WIDTH`
IDFROM=`expr $TMP2 + 1`
python smi2sdf.py input.smi -i ${IDFROM} -w ${WIDTH}
