#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=13
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4G
#SBATCH --time=23:59:00
#SBATCH --partition=cpu

module load Gurobi
module load Julia
srun -l --multi-prog ./experiments/slurm_stats.conf
