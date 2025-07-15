#!/bin/bash
#FLUX: --job-name=eval-clevr-50
#FLUX: -t=36000
#FLUX: --priority=16

source ~/.bashrc
conda activate idefics
cd /home/naveensu/
python eval-idefics-clevr.py -m /data/user_data/naveensu/idefics-50 -o idefics-50_clevr.csv
