#!/bin/bash
#SBATCH --job-name=isobutane_matlab
#SBATCH --output=isobutane_matlab.out
#SBATCH --error=isobutane_matlab.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6400
#SBATCH --time=7-00:00:00
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=1

ml load matlab
matlab -r main_train_isobutane_new
