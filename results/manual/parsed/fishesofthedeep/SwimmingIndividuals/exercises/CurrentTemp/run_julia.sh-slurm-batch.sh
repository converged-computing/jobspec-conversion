#!/bin/bash
#SBATCH --job-name=SI_HC
#SBATCH --output=serial_job_%j.out
#SBATCH --mail-user=matthew.woodstock@whoi.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=20gb
#SBATCH --time=1-00:00:00
#SBATCH --partition=compute

date
module load julia                  # Load the julia module
echo "Running julia script for SwimmingIndividuals.jl"
julia /vortexfs1/scratch/matthew.woodstock/SwimmingIndividuals/Exercises/HighFood/CurrentTemp/model.jl
date
