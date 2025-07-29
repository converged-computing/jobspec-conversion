#!/bin/bash
#SBATCH --output=log_%1
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --qos=low
#SBATCH --constraint=ntasks-per-node=6

module load matlab/R2022a 
NCL=$1
matlab -nodesktop -nosplash -nodisplay -r "NCL=$NCL;Spec_main;quit" >> log_$NCL
