#!/bin/bash
#SBATCH --job-name=preprocess
#SBATCH --output=preprocess%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --constraint=ntasks-per-node=32

snakemake -s preprocess.smk -j 32
