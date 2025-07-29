#!/bin/bash
#SBATCH --error=std_err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --nodelist=GPU43

source activate nlp
python hlt.py
