#!/bin/bash
#SBATCH --job-name=greasy
#SBATCH --output=greasy-%j.out
#SBATCH --error=greasy-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=201
#SBATCH --cpus-per-task=2
#SBATCH --time=2-00:00:00
#SBATCH --chdir=hpc/greasy/logs

export I_MPI_PMI_VALUE_LENGTH_MAX='512'

if uname -a | grep -q amd
then
	module load impi intel greasy
else
	module load greasy
fi
export I_MPI_PMI_VALUE_LENGTH_MAX=512
TASKS_FILE=$1
greasy $TASKS_FILE
