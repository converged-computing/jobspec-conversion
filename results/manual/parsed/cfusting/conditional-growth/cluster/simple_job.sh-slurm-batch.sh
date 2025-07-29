#!/bin/bash
#SBATCH --job-name=catnap
#SBATCH --output=MyJob.%j.%N.out
#SBATCH --error=MyJob.%j.%N.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:t4:4
#SBATCH --mem=8g
#SBATCH --time=7-00:00:00
#SBATCH --partition=preempt
#SBATCH --chdir=/cluster/home/skrieg01

module load singularity/3.6.1
singularity exec --nv --writable-tmpfs image_latest.sif python conditional-growth/experiments/distance_traveled/optimize_sim.py
