#!/bin/bash
#SBATCH --job-name=Wrapper
#SBATCH --mail-user=daisuke.shimaoka@monash.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=80000
#SBATCH --time=02:00:00
#SBATCH --array=1-20

module load matlab/r2021a
matlab -nodisplay -nodesktop -nosplash < awake_unconscious_NMclassification_channels.m
