#!/bin/bash
#SBATCH --job-name=NGS580-GATK4_test
#SBATCH --output=slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=48G
#SBATCH --time=5-00:00:00
#SBATCH --constraint=ntasks-per-node=1

./nextflow run main.nf
