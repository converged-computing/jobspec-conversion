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
#SBATCH --partition=gpu
#SBATCH --exclude=pgpu01

export PYTHONPATH='/cluster/tufts/liulab/lib/anaconda3/envs/lipinggpu/lib/python3.7/site-packages/:$PYTHONPATH'

nvidia-smi
source activate lipinggpu
export PYTHONPATH="/cluster/tufts/liulab/lib/anaconda3/envs/lipinggpu/lib/python3.7/site-packages/:$PYTHONPATH"
stdbuf -o0 python -u run-exp.py kegg_20_pc_rc -m ep -e lp
