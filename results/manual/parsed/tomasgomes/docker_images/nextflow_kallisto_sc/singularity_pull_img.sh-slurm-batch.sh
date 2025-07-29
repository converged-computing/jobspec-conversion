#!/bin/bash
#SBATCH --job-name=getnex
#SBATCH --output=outfile.txt
#SBATCH --error=errfile.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=00:15:00
#SBATCH --nodelist=compute-2

singularity pull nextflow_kallisto_sc.sif docker://tomasgomes/nextflow_kallisto_sc:0.3
