#!/bin/bash
#SBATCH --job-name=topomovie1
#SBATCH --account=uoa00424
#SBATCH --output=Topovideo1_%A_%a.out
#SBATCH --mail-user=hjin317@aucklanduni.ac.nz
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=60G
#SBATCH --time=02:00:00
#SBATCH --partition=prepost
#SBATCH --array=2-5

module load MATLAB/2017b
matlab -nodisplay -r Topovideo1
