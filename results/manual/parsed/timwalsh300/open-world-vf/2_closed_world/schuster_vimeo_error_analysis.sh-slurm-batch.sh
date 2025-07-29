#!/bin/bash
#SBATCH --job-name=schuster_vimeo_error_analysis
#SBATCH --output=/home/timothy.walsh/VF/2_closed_world/%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=64GB
#SBATCH --time=06:00:00
#SBATCH --partition=beards

source /share/spack/gcc-7.2.0/miniconda3-4.5.12-gkh/bin/activate /share/spack/gcc-7.2.0/miniconda3-4.5.12-gkh/envs/tflow
python3 /home/timothy.walsh/VF/2_closed_world/schuster_vimeo_error_analysis.py
