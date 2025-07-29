#!/bin/bash
#SBATCH --account=def-m2nagapp
#SBATCH --mail-user=hosseinkeshavarz1997@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=23:00:00

source /home/hkshvrz/projects/def-m2nagapp/hkshvrz/jit-bugpred/venv/bin/activate
which python
module load java/11
unset JAVA_TOOL_OPTIONS
python -u src/gumtree.py
