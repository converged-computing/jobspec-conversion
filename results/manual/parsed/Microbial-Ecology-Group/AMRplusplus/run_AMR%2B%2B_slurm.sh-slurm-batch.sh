#!/bin/bash
#SBATCH --job-name=AMR++
#SBATCH --output=AMR++_log.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=40G
#SBATCH --time=1-00:00:00
#SBATCH --partition=amilan

conda activate AMR++_env  # Explore the installation instructions on github to see how to install this environment
nextflow run main_AMR++.nf -profile local --threads 8 # This will use 8 threads, which corresponds with "--cpus-per-task=8". 
