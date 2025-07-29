#!/bin/bash
#SBATCH --job-name=ABQPlot
#SBATCH --output=plot.out
#SBATCH --error=plot.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=18:00:00
#SBATCH --partition=fat
#SBATCH --constraint=ntasks-per-node=28

module load easybuild
module load prl
module load python/3.6.0
cd /home/abubie/qual_ind_swp
./Qual_Mean_Calc.py
echo $"Qual plot is complete"
