#!/bin/bash
#SBATCH --job-name=procSpike
#SBATCH --mail-user=elizabeth.zavitz@monash.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=56320
#SBATCH --time=01:00:00
#SBATCH --array=1-11

module load matlab
matlab -nodisplay -nojvm -nosplash < /home/earsenau/code/processSpikingMoveStim/RUNAnalysis_brain.m
