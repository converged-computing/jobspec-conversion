#!/bin/bash
#SBATCH --job-name=fixids
#SBATCH --output=log/%x_%j.out
#SBATCH --error=log/%x_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1gb
#SBATCH --time=1-06:00:00
#SBATCH --partition=bluemoon

pwd; hostname; date
set -e
spack load python@3.7.7
python /gpfs1/home/m/r/mriedel/pace/dsets/code/fix_ids.py
date
