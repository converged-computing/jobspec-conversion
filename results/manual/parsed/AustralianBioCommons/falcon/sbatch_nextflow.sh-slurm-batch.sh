#!/bin/bash
#SBATCH --account=$PAWSEY_PROJECT
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=28
#SBATCH --time=1-00:00:00
#SBATCH --partition=workq

unset SBATCH_EXPORT
module load nextflow
srun nextflow run main.nf -profile conda
