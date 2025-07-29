#!/bin/bash
#SBATCH --job-name=zcpfJobUpdate
#SBATCH --output=zcpfJobUpdate.%J.out
#SBATCH --error=zcpfJobUpdate.%J.err
#SBATCH --mail-user=fernando.zhapacamacho@kaust.edu.sa
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=08:00:00

python update.py
