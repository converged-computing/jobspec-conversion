#!/bin/bash
#SBATCH --job-name=main
#SBATCH --nodes=15
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --partition=shared-gpu

cores=8
for dir in "$1"/*
do
if [ -d "$dir" ]
then
echo $dir
srun -N 1 -n 1 -c $cores -o "$dir".out --open-mode=append ./main_wrapper.sh --action train --epochs 50 --learning-rule stdp --load --directory $dir &
fi
done
