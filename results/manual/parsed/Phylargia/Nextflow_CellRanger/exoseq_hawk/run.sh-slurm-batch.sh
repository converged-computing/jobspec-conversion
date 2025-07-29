#!/bin/bash
#SBATCH --job-name=exoseq_hawk
#SBATCH --account=scw1557
#SBATCH --output=slurm/%J.out
#SBATCH --error=slurm/%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20GB
#SBATCH --time=1-00:00:00

module load nextflow/21.10.6
cd /scratch/c.c1845715/nextflow_cellranger/exoseq_hawk # Change User ID
nextflow run main.nf --genome mouse --input 'input/input.csv' -with-trace
