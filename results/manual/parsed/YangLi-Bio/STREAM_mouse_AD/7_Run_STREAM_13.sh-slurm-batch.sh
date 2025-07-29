#!/bin/bash
#SBATCH --job-name=Run_STREAM_13+_months
#SBATCH --account=PCON0022
#SBATCH --output=Run_STREAM_13+_months.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=300GB
#SBATCH --time=1-10:20:59
#SBATCH --constraint=ntasks-per-node=8

set -e
cd /fs/ess/PCON0022/liyang/STREAM/Case_2_AD/Codes/
module load R/4.1.0-gnu9.1
Rscript 7_STREAM_13.R
