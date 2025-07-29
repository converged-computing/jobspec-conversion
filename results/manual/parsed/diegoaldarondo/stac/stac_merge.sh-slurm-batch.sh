#!/bin/bash
#SBATCH --job-name=stac_merge
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=40000
#SBATCH --time=00:01:00
#SBATCH --constraint=intel&avx2

set -e
source ~/.bashrc
setup_mujoco200_3.7
stac-merge ./stac
