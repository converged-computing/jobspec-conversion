#!/bin/bash
#FLUX: --job-name=clevr-idefics-mqa
#FLUX: -t=36000
#FLUX: --priority=16

source ~/.bashrc
conda activate idefics
cd /home/naveensu/
python eval-idefics.py
