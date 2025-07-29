#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=126G
#SBATCH --time=7-22:00:00
#SBATCH --constraint=intel

python preprocess.py
