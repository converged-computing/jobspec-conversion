#!/bin/bash
#SBATCH --job-name=AD_freq2
#SBATCH --output=AD_freq2.out
#SBATCH --error=AD_freq2.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=long
#SBATCH --constraint=ntasks-per-node=28

ml easybuild GCC/6.3.0-2.27 OpenMPI/2.0.2 Python/3.6.1
pip list installed | grep numpy
python part2FreqDist.py -f1 22_3H_both_S16_L008_R1_001.fastq  -f2 22_3H_both_S16_L008_R2_001.fastq  \
-f3 32_4G_both_S23_L008_R1_001.fastq -f4 32_4G_both_S23_L008_R2_001.fastq
