#!/bin/bash
#SBATCH --account=def-lelis
#SBATCH --output=%N-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=8000M
#SBATCH --time=7-00:00:00

module load python/3.6
source tensorflow/bin/activate
python src/main.py ${scheme} -a ${algorithm} -l ${loss} -m ${model} -p problems/witness/puzzles_4x4_50k_train/ --learn -d Witness -b 2000
