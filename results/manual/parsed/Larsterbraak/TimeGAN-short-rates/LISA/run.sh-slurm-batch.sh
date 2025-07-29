#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:30:00

module purge #Unload all loaded modules
module load 2019
module load TensorFlow
echo Running on Lisa System
python3 $HOME/main.py
