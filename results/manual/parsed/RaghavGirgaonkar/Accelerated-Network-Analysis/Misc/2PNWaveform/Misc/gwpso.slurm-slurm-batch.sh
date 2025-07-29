#!/bin/bash
#SBATCH --job-name=rungwpso
#SBATCH --output=/scratch/09197/raghav/rungwpso.o%j
#SBATCH --error=/scratch/09197/raghav/rungwpso.e%j
#SBATCH --mail-user=raghav.girgaonkar01@utrgv.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=03:00:00
#SBATCH --partition=normal

module load matlab
matlab -batch  "cd /work/09197/raghav/ls6/Accelerated-Network-Analysis/2PNWaveform; rungwpso"
