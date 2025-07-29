#!/bin/bash
#SBATCH --job-name=Super
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=32GB
#SBATCH --time=1-00:45:00
#SBATCH --partition=amd

module load python/3.8.6
cd $HOME/AutoML
python autocausality_AutoSuper.py
