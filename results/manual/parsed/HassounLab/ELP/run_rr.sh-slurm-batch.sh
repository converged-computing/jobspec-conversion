#!/bin/bash
#SBATCH --job-name=elp
#SBATCH --account=normal
#SBATCH --output=logs/output-ep-rr-%j.log
#SBATCH --error=logs/output-ep-rr-%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50gb
#SBATCH --time=1-00:00:00
#SBATCH --exclude=pgpu01

export PYTHONPATH='/cluster/tufts/liulab/lib/anaconda3/envs/lipinggpu/lib/python3.7/site-packages/:$PYTHONPATH'

nvidia-smi
source activate lipinggpu
export PYTHONPATH="/cluster/tufts/liulab/lib/anaconda3/envs/lipinggpu/lib/python3.7/site-packages/:$PYTHONPATH"
stdbuf -o0 python -u run-exp.py kegg_20_maccs -m ep -e rr
