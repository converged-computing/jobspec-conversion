#!/bin/bash
#SBATCH --job-name=Wrapper
#SBATCH --mail-user=daisuke.shimaoka@monash.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=130000
#SBATCH --time=15:00:00
#SBATCH --array=1-10

module load matlab/r2021a
module load gst-libav
matlab -nodisplay -nodesktop -nosplash < makeStimDataBase.m
