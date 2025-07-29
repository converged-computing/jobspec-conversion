#!/bin/bash
#SBATCH --job-name=Rscript
#SBATCH --output=log.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=50G
#SBATCH --time=3-00:00:00

time python run_Speed_up.py --contigs test.fasta --len 1999
