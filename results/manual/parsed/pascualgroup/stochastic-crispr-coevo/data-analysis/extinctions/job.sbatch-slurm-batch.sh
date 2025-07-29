#!/bin/bash
#SBATCH --job-name=crispr-test
#SBATCH --account=pi-pascualmm
#SBATCH --output=output.txt
#SBATCH --mail-user=armun@uchicago.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000m
#SBATCH --time=04:00:00
#SBATCH --partition=broadwl
#SBATCH --chdir=/home/armun/crispr-sweep-6-9-2021/individual-test

module purge
module load julia
julia /home/armun/crispr-sweep-6-9-2021/main.jl parameters.json &> script_output.txt
