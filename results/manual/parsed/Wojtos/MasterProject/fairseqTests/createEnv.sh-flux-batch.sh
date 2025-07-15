#!/bin/bash
#FLUX: --job-name=spicy-lizard-3607
#FLUX: --urgency=16

module load plgrid/tools/python-intel/3.6.2
module load plgrid/apps/cuda/10.1
virtualenv -p python $HOME/fairseqTests/venv
source $HOME/fairseqTests/venv/bin/activate
pip install fairseq
pip install fastBPE sacremoses subword_nmt
