#!/bin/bash
#SBATCH --account=y95
#SBATCH --mail-user=darcy.a.jones@postgrad.curtin.edu.au
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=28
#SBATCH --time=1-00:00:00
#SBATCH --partition=workq

module load nextflow/18.10.1-bin
nextflow run \
  -resume \
  -profile pawsey_zeus \
  ./psearch.nf \
    --max_cpus 28 \
    --proteins_db "sequences/proteins" \
    --global_profile "clusters/global_profile"
