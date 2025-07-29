#!/bin/bash
#SBATCH --job-name=phase_separation
#SBATCH --account=INF23_biophys_2
#SBATCH --output=%x_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=28
#SBATCH --mem=1024M
#SBATCH --time=10:00:00
#SBATCH --constraint=ntasks-per-node=1

source ~/.bashrc
julia -p 28 distributed_je.jl
