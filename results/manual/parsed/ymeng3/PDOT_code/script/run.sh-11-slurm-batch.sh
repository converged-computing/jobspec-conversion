#!/bin/bash
#SBATCH --job-name=pdot_dataset1
#SBATCH --account=pi-haihaolu
#SBATCH --output=/home/ymeng3/result/result11.txt
#SBATCH --error=/home/ymeng3/result/error11.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=16G

module load julia  # Load Julia module, if available 
julia /home/ymeng3/experiments/code/pdot_code2/test/dataset1.jl
