#!/bin/bash
#SBATCH --job-name=rmdup
#SBATCH --output=rmdup.job.job.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=02:00:00

module load snakemake/7.6.0
snakemake --jobs 101 --latency-wait 240 --cluster 'sbatch --parsable --distribution=arbitrary' --snakefile ../_h/snakemake.slurm.script
