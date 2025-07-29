#!/bin/bash
#SBATCH --output=logs/log-%j.out
#SBATCH --error=logs/log-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

module load plgrid/tools/python-intel/3.6.2
module load plgrid/apps/cuda/10.1
virtualenv -p python $HOME/fairseqTests/venv
source $HOME/fairseqTests/venv/bin/activate
pip install fairseq
pip install fastBPE sacremoses subword_nmt
