#!/bin/bash
#SBATCH --job-name=GZ_fastq
#SBATCH --output=slurm.GZ_fastq.out
#SBATCH --error=slurm.GZ_fastq.err
#SBATCH --mail-user=kcolney@asu.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

snakemake --snakefile Snakefile -j 30 --nolock --latency-wait 15 --rerun-incomplete --cluster "sbatch -n 1 --nodes 1 -c 8 -t 04:00:00"
