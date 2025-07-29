#!/bin/bash
#SBATCH --account=gutintelligencelab
#SBATCH --output=test_.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=7
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=150gb
#SBATCH --time=3-00:00:00
#SBATCH --partition=gpu

module purge
module load apptainer
apptainer run --nv ~/pytorch-1.8.1.sif main.py 
