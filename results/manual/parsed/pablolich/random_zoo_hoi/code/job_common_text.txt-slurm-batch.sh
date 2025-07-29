#!/bin/bash
#SBATCH --job-name=trialrun
#SBATCH --account=pi-salesina
#SBATCH --output=trialrun.out
#SBATCH --error=trialrun.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=40000
#SBATCH --time=1-00:00:00
#SBATCH --partition=caslake
#SBATCH --constraint=ntasks-per-node=1

module load julia/1.9.0
