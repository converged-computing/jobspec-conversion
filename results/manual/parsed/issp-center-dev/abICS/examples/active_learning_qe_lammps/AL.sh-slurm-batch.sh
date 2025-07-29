#!/bin/bash
#SBATCH --job-name=spinel
#SBATCH --nodes=8
#SBATCH --ntasks=1024
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=i8cpu

echo start AL sample
srun -n 8 abics_mlref input.toml >> abics_mlref.out
echo start parallel_run 1
sh parallel_run.sh
echo start AL final
srun -n 8 abics_mlref input.toml >> abics_mlref.out
echo start training
abics_train input.toml >> abics_train.out
echo Done
