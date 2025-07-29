#!/bin/bash
#SBATCH --job-name=0_disp2d
#SBATCH --account=action
#SBATCH --output=disp2d_output0.slurm
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2GB
#SBATCH --time=1-00:00:00

/scratch/mtayl29/rad-in-rust/target/release/rad-in-rust disp2d 1.0 -0.60205999132 -1.0 1 480 21 4
