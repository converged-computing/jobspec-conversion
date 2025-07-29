#!/bin/bash
#SBATCH --job-name=Tox21_models
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=128G
#SBATCH --time=5-00:00:00
#SBATCH --partition=amd
#SBATCH --constraint=ntasks-per-node=1

module load any/jdk/1.8.0_265
module load nextflow
module load any/singularity/3.5.3
module load squashfs/4.4
nextflow run main.nf
