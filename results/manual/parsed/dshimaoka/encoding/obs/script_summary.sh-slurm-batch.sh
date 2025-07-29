#!/bin/bash
#SBATCH --job-name=Summary
#SBATCH --mail-user=daisuke.shimaoka@monash.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=9
#SBATCH --gres=gpu:1
#SBATCH --mem=12000
#SBATCH --time=1-00:00:00
#SBATCH --partition=m3g

module load matlab
matlab -nodisplay -nodesktop -nosplash < summaryAcrossPix.m
