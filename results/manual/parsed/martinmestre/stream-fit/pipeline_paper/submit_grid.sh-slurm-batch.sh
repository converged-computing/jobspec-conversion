#!/bin/bash
#SBATCH --job-name=chi2stream
#SBATCH --mail-user=mmestre@fcaglp.unlp.edu.ar
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=64

. /etc/profile
python grid_chi2stream.py
