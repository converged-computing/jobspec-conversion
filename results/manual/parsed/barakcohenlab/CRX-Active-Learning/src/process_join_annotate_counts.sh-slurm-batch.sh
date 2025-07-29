#!/bin/bash
#SBATCH --output=log/process_join_annotate_counts.out
#SBATCH --error=log/process_join_annotate_counts.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G

eval $(spack load --sh miniconda3)
source activate active-learning
python3 src/process_and_join_counts.py
python3 src/annotate_data.py
