#!/bin/bash
#SBATCH --job-name=tut_povray
#SBATCH --output=povray_%j.out
#SBATCH --error=povray_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00

ml GCC/10.2.0
ml POV-Ray/3.7.0.8
povray benchmark.ini +Opovray_$SLURM_JOB_ID.png
