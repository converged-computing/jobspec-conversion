#!/bin/bash
#SBATCH --output=balrog.stdout.%j.%N
#SBATCH --error=balrog.stderr.%j.%N
#SBATCH --mail-user=david.molik@usda.gov
#SBATCH --mail-type=START,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --partition=long

module load apptainer
module load nextflow/23.10.1
nextflow run . -c configs/ceres/ceres.cfg -resume
