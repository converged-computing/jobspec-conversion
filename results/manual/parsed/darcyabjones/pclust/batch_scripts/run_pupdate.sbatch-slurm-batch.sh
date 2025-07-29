#!/bin/bash
#SBATCH --account=y95
#SBATCH --mail-user=darcy.a.jones@postgrad.curtin.edu.au
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=28
#SBATCH --time=1-00:00:00

module load nextflow/18.10.1-bin
nextflow run \
  -resume \
  -profile pawsey_zeus \
  ./pupdate.nf \
    --max_cpus 28 \
    --nomsa \
    --proteins "data/phi45.fas" \
    --global_clusters "global_clusters" \
    --global_seqs "global_seqs" 
