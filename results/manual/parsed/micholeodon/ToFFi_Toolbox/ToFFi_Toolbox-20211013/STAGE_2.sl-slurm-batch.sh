#!/bin/bash
#SBATCH --job-name=H1_S2
#SBATCH --output=S2-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=12800
#SBATCH --time=00:10:00
#SBATCH --partition=small
#SBATCH --constraint=ntasks-per-node=3
#SBATCH --array=1-1
#SBATCH --licenses=matlab_dct@licencje.task.gda.pl:1

iStage=2
cd "STAGE_$iStage/scripts/"
folder=`pwd`
module load tryton/matlab/2021a
matlab -nodisplay -nodesktop -logfile $folder/../../STAGE_${iStage}.log <  $folder/RUN.m 
