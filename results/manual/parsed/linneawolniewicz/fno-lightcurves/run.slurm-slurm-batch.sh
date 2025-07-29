#!/bin/bash
#SBATCH --job-name=fno
#SBATCH --account=koa
#SBATCH --output=logs/slurm_output/job-%A.out
#SBATCH --mail-user=linneamw@hawaii.edu
#SBATCH --mail-type=START,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=36gb
#SBATCH --time=30-00:00:00
#SBATCH --partition=koa

source ~/profiles/auto.profile
source activate fno
python scripts/fno_signal_classification.py
