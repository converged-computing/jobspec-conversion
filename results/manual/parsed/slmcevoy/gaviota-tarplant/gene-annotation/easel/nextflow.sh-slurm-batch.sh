#!/bin/bash
#SBATCH --job-name=gvtp
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --partition=general
#SBATCH --qos=general

module load nextflow
SINGULARITY_TMPDIR=$PWD/tmp
export SINGULARITY_TMPDIR
TMPDIR=$PWD/tmpdir
export TMPDIR
nextflow run -hub gitlab PlantGenomicsLab/easel-benchmarking-v2-nf -profile singularity,xanadu -params-file gvtp.yaml
