#!/bin/bash
#SBATCH --job-name=seasfst
#SBATCH --output=./slurmOut/spacfst.%A_%a.out
#SBATCH --error=./slurmOut/spacfst.%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=40G
#SBATCH --time=1-00:00:00
#SBATCH --partition=bluemoon
#SBATCH --array=1-469

module load spack/spack-0.18.1
spack load r@4.2.1 r-sf
spack load openjdk@11.0.15_10
Rscript \
1.0.seasonal.fst.revision.R \
${SLURM_ARRAY_TASK_ID} 
echo "done"
date
