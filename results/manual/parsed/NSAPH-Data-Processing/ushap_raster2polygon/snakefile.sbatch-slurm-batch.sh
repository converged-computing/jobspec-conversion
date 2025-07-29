#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=48GB
#SBATCH --time=1-00:00:00
#SBATCH --partition=serial_requeue

snakemake --cores 1
