#!/bin/bash
#SBATCH --job-name=AD_R1
#SBATCH --output=AD_R1.out
#SBATCH --error=AD_R1.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --partition=short
#SBATCH --constraint=ntasks-per-node=28

ml easybuild GCC/6.3.0-2.27 OpenMPI/2.0.2 Python/3.6.1
python part1Hist1.py -f 22_3H_both_S16_L008_R1_001.fastq 
