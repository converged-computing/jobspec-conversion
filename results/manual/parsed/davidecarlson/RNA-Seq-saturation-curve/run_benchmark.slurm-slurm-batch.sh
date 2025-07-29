#!/bin/bash
#SBATCH --job-name=benchmark
#SBATCH --output=benchmark.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=20

module load diffexp/1.0
snakemake --cores 20 -s snakefile-benchmark 
