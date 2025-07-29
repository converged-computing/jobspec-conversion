#!/bin/bash
#SBATCH --job-name=matlab_job
#SBATCH --output=%x_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5G
#SBATCH --time=00:05:00
#SBATCH --partition=day

cd /home/adw54/Documents/egc_hpc_manual
module load MATLAB/2019a-parallel
matlab -nodisplay < matlab/master.m
