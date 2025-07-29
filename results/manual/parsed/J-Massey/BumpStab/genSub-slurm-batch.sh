#!/bin/bash
#SBATCH --job-name=RA
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=04:30:00
#SBATCH --partition=amd
#SBATCH --constraint=ntasks-per-node=64

module load texlive
module load conda
source activate an
python resolvent/spDMD.py
python resolvent/resolvent_analysis.py
python resolvent/plot_gain.py
python resolvent/plot_peaks.py
