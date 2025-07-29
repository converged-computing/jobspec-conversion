#!/bin/bash
#SBATCH --job-name=tensorflow
#SBATCH --account=hpcac
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=jupiter
#SBATCH --constraint=jupiter_k20

module purge
module load ml/tensorflow/1.4.1-py27
python test.py
