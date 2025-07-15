#!/bin/bash
#FLUX: --job-name=sudoku-solver   # Nom de la tâche
#FLUX: --priority=16

module load gcc/10.2.0
begin=$(($SLURM_ARRAY_TASK_ID*10000000000  ))
end=$((($SLURM_ARRAY_TASK_ID+1)*10000000000 ))
OMP_NUM_THREADS=24 ./build/wfc -s$begin-$end data/empty-6x6.data >> first/first$SLURM_ARRAY_TASK_ID.dat
