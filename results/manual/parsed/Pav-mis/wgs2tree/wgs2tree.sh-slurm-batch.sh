#!/bin/bash
#SBATCH --job-name=wgs2tree
#SBATCH --account=pawsey0812
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1

module load singularity/3.11.4-nompi
module load nextflow/23.10.0
unset SBATCH_EXPORT
nextflow run wgs2tree/main.nf --lineage 'actinopterygii_odb10' --out 'NF'
