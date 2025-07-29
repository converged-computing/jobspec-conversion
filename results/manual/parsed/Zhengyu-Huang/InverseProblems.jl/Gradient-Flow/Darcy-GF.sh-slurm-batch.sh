#!/bin/bash
#SBATCH --job-name=Darcy-GF
#SBATCH --output=Darcy-GF
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=128G
#SBATCH --time=7-00:00:00

julia  Darcy-GF.jl 
