#!/bin/bash
#SBATCH --job-name=elp
#SBATCH --account=normal
#SBATCH --output=logs/output-ep-lp-%j.log
#SBATCH --error=logs/output-ep-lp-%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=75gb
#SBATCH --time=1-00:00:00
#SBATCH --exclude=pgpu01

nvidia-smi
source activate lipinggpu
stdbuf -o0 python -u run-exp.py kegg_20_node_only -m ep -e viz
stdbuf -o0 python -u run-exp.py kegg_20_maccs -m ep -e viz
