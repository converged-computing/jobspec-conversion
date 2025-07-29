#!/bin/bash
#SBATCH --job-name=fittest
#SBATCH --output=logs/GA/fittest/i-%A-%a.o
#SBATCH --error=logs/GA/fittest/i-%A-%a.e
#SBATCH --mail-user=mvanega1@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=htc
#SBATCH --chdir=/home/mvanega1/SpatialRust
#SBATCH --array=1-8

module purge
module load julia/1.9.0
echo `date +%F-%T`
ulimit -s 262144
julia ~/SpatialRust/scripts/GA/runFittest.jl /home/mvanega1/SpatialRust/results/GA4/fittest/parsdfNF.csv $SLURM_ARRAY_TASK_ID 100
echo `date +%F-%T`
exit 0
