#!/bin/bash
#SBATCH --job-name=hopf_inference
#SBATCH --account=def-gonzalez
#SBATCH --output=slurm-hopf_inference.%A.%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=00:45:00
#SBATCH --array=1-256

module load julia/1.9.1
julia cluster_hopf_inference.jl
