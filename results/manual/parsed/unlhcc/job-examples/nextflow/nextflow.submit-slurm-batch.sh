#!/bin/bash
#SBATCH --job-name=nextflow
#SBATCH --output=nextflow.%J.out
#SBATCH --error=nextflow.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1GB
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load nextflow
nextflow run hello.nf -c config 
