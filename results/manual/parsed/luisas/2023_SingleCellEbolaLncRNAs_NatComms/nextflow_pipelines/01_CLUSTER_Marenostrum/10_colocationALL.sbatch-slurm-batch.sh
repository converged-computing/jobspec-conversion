#!/bin/bash
#SBATCH --job-name=NextflowQAPipeline
#SBATCH --output=out/Nextflow-%j.out
#SBATCH --error=err/Nextflow-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --qos=debug
#SBATCH --chdir=.

module load java/8u131
module load intel/2017.1
module load R/3.6.1
Rscript /gpfs/projects/bsc83/Projects/Ebola/code/ebola/nextflow_pipelines/scripts/SC/08b_colocationAll.R
