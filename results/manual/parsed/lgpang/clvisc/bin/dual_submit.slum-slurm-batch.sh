#!/bin/bash
#SBATCH --job-name=CLHydro
#SBATCH --output=log/%a_%j.out
#SBATCH --error=log/%a_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2048
#SBATCH --time=01:00:00
#SBATCH --constraint=dual

unset DISPLAY
module load python/2.7.8
module load amdappsdk/2.9
python visc.py
