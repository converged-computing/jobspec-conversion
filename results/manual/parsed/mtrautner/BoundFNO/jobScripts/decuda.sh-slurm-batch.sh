#!/bin/bash
#SBATCH --job-name=preprocess_smooth
#SBATCH --output=outputs/decuda.out
#SBATCH --mail-user=mtrautne@caltech.edu
#SBATCH --mail-type=fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=00:08:00
#SBATCH --partition=gpu
#SBATCH --array=1

cd ../models
python  -u decuda_model.py
