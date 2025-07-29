#!/bin/bash
#SBATCH --job-name=sudoku-solver
#SBATCH --output=err/mon_programme_%A_%a.out
#SBATCH --error=err/mon_programme_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --array=1-200

module load gcc/10.2.0
begin=$(($SLURM_ARRAY_TASK_ID*10000000000  ))
end=$((($SLURM_ARRAY_TASK_ID+1)*10000000000 ))
OMP_NUM_THREADS=24 ./build/wfc -s$begin-$end data/empty-6x6.data >> first/first$SLURM_ARRAY_TASK_ID.dat
