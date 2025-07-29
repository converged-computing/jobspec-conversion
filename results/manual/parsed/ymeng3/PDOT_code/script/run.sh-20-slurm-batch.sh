#!/bin/bash
#SBATCH --job-name=pdot_dataset1
#SBATCH --account=pi-haihaolu
#SBATCH --output=/home/ymeng3/result/result20.txt
#SBATCH --error=/home/ymeng3/result/error20.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=16G

module load julia  # Load Julia module, if available 
julia /home/ymeng3/experiments/code/pdot_code1/test/dataset2.jl
