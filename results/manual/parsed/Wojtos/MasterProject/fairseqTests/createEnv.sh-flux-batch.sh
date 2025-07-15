#!/bin/bash
#FLUX: --job-name=scruptious-cherry-1725
#FLUX: --priority=16

module load plgrid/tools/python-intel/3.6.2
module load plgrid/apps/cuda/10.1
virtualenv -p python $HOME/fairseqTests/venv
source $HOME/fairseqTests/venv/bin/activate
pip install fairseq
pip install fastBPE sacremoses subword_nmt
