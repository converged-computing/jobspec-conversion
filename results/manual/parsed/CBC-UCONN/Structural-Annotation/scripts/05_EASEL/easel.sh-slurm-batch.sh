#!/bin/bash
#SBATCH --job-name=EASEL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --partition=general
#SBATCH --qos=general

module load nextflow
SINGULARITY_TMPDIR=$PWD
export SINGULARITY_TMPDIR
nextflow run -hub gitlab PlantGenomicsLab/easel -profile singularity,xanadu -params-file params.yaml 
