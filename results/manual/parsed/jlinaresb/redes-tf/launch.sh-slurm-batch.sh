#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=32GB
#SBATCH --time=01:00:00
#SBATCH --partition=shared
#SBATCH --qos=shared_short

module load cesga/2018 gcc/6.4.0 pandas/1.0.0-python-3.8.1 scipy/1.4.1-python-3.8.1 tensorflow/2.2.1-python-3.8.1
python pipeline_classif.py
