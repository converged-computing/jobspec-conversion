#!/bin/bash
#SBATCH --job-name=soy_test_alignment
#SBATCH --output=/dev/null
#SBATCH --error=/dev/null
#SBATCH --mail-user=jhgille2@ncsu.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=72
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=3000
#SBATCH --time=12:00:00
#SBATCH: --exclusive

module load singularity
singularity exec conda.sif R CMD BATCH run.R
