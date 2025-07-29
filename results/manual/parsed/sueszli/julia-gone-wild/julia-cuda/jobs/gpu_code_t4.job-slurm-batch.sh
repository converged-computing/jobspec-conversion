#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=2
#SBATCH --time=00:05:00
#SBATCH --partition=q_student_gpu

. vars_in.sh
BINARY="../src/juliaset_gpu"
BSIZE_X=32
BSIZE_Y=1
for SIZE in "${SIZE_LIST[@]}"
do 
  $BINARY -r $SIZE $SIZE -b $BSIZE_X $BSIZE_Y -n $NREP -o "task4_gpu_${SIZE}.csv"
done
