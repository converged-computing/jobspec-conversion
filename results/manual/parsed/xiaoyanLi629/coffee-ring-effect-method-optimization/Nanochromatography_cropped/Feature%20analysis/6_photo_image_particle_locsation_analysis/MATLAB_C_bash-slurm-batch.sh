#!/bin/bash
#SBATCH --job-name=test
#SBATCH --mail-user=lixiaoy5@msu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=64
#SBATCH --time=1-06:00:00

MATLAB/2021a Pixel_js_analysis.m
scontrol show job $SLURM_JOB_ID           ### write job information to output file
