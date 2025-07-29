#!/bin/bash
#SBATCH --account=project_2002389
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=10G
#SBATCH --time=00:10:10

module load maestro
module load bioconda
source activate nextflow
nextflow run  test_real.nf
