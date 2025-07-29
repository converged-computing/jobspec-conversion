#!/bin/bash
#SBATCH --account=renard
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=5-00:00:00
#SBATCH --partition=magic
#SBATCH --constraint=ARCH:X86

snakemake --unlock
snakemake --profile slurm
