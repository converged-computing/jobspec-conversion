#!/bin/bash
#SBATCH --job-name=calculate SNR
#SBATCH --output=job.%J.out
#SBATCH --error=job.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=51
#SBATCH --mem=2G
#SBATCH --time=12:00:00

module load r-doparallel/1.0.11-py2-r3.5-tlbjucn
module load r-devtools/1.12.0-py2-r3.5-3zfj3n2
module load r-expm/0.999-2-py2-r3.5-p6ucwpc
module load r-hmisc/4.1-1-py2-r3.5-2wm5k3n
module load r-numderiv/2016.8-1-py2-r3.5-5pb7s6o
module load r-mass/7.3-47-py2-r3.5-xtsjvcy
module load gcc/7.3.0-xegsmw4
module load r/3.6.0-py2-fupx2uq
cd /work/LAS/zhuz-lab/xchang/Change-pointDetection/RealData/
Rscript ./SNR.R
