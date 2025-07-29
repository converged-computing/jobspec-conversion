#!/bin/bash
#SBATCH --job-name=procSpike
#SBATCH --mail-user=elizabeth.zavitz@monash.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=30000
#SBATCH --time=00:15:00
#SBATCH --array=1-384

module load matlab/r2021a
matlab -nodisplay -nojvm -nosplash < /home/earsenau/code/processSpikingMoveStim/RUNAnalysis_mdbExtract.m
