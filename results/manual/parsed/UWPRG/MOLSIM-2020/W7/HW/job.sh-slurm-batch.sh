#!/bin/bash
#SBATCH --job-name=molsim_hw3
#SBATCH --account=pfaendtner
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=22G
#SBATCH --time=00:30:00
#SBATCH --partition=pfaendtner

cat conditions.txt | while read line; do
  echo $line
done
