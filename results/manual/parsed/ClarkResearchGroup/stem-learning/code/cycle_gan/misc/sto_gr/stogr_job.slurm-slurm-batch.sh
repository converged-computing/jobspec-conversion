#!/bin/bash
#SBATCH --account=bbhg-delta-gpu
#SBATCH --output=slurm-%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32g
#SBATCH --time=06:00:00
#SBATCH --partition=gpuA100x4
#SBATCH --constraint=ntasks-per-node=1

module purge 
module list  
echo "job is starting on `hostname`"
singularity run --nv /sw/external/NGC/tensorflow:22.02-tf2-py3 python3 stogr_cycleGAN_for_STEM.py ${mat} ${num}
