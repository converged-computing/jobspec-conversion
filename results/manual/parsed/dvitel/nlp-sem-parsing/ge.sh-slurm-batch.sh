#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --partition=Quick
#SBATCH --chdir=/data/dvitel/semParse
#SBATCH --nodelist=GPU45

conda activate semParse2
python3 /home/d/dvitel/semp/ge.py "$@"
