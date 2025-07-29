#!/bin/bash
#SBATCH --job-name=Run_enrichR
#SBATCH --account=PCON0022
#SBATCH --output=Run_enrichR.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100GB
#SBATCH --time=11:50:59
#SBATCH --constraint=ntasks-per-node=8

set -e
cd /fs/ess/PCON0022/liyang/STREAM/benchmarking/GLUE/Codes/
module load R/4.1.0-gnu9.1
Rscript 8_Run_enrichR.R
