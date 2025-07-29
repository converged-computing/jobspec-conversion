#!/bin/bash
#SBATCH --job-name=tauog
#SBATCH --output=/scratch/09197/raghav/PSD-Estimation/tauog.o%j
#SBATCH --error=/scratch/09197/raghav/PSD-Estimation/tauog.e%j
#SBATCH --mail-user=raghav.girgaonkar01@utrgv.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=18:00:00

module load matlab
matlab -batch  "cd /work/09197/raghav/ls6/MFComparison-Testing_iMac; rungwpso  /work/09197/raghav/ls6/MFComparison-Testing_iMac/allparamfiles_og.json"
