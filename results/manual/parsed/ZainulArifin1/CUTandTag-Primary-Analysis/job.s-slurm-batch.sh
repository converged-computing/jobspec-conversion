#!/bin/bash
#SBATCH --job-name=CUT&Tag Pipeline
#SBATCH --output=outLog
#SBATCH --error=errLog
#SBATCH --mail-user=some_email@gmail.com
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --constraint=ntasks-per-node=10

snakemake --cores <num_cores> -s <snakefile_name>
