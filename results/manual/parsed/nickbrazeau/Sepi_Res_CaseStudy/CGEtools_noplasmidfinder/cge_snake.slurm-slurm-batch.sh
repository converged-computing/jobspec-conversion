#!/bin/bash
#SBATCH --output=%A_Sepidermidis_res.out
#SBATCH --mail-user=nbrazeau@med.unc.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=49512
#SBATCH --time=11-00:00:00

snakemake -s run_CGEtools.snake.py --cluster "sbatch -n1 -t 1-00:00:00 --mem 49152 -o Cluster_%A_job.out" -j 8
