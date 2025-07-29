#!/bin/bash
#SBATCH --job-name=misTreat
#SBATCH --error=misTreat.err
#SBATCH --nodes=1
#SBATCH --ntasks=160
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time=5-00:00:00
#SBATCH --array=18

ulimit -l unlimited
module load gcc/6.2.0 R/4.0.1
module load openmpi/4.1.1
mpirun --mca btl tcp,self Rscript tmle_MultinomialTrts.R ${SLURM_ARRAY_TASK_ID} 'binomial' 'TRUE' 'TRUE' 'FALSE' 'FALSE' 'TRUE' 'FALSE' 'FALSE'
