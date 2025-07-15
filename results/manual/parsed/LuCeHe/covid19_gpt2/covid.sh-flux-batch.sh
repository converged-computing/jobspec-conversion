#!/bin/bash
#FLUX: --job-name=lovely-soup-8793
#FLUX: -c=4
#FLUX: -t=172800
#FLUX: --priority=16

module load python/3.6
source ~/projects/def-jrouat/lucacehe/denv2/bin/activate
cd ~/projects/def-jrouat/lucacehe/work/covid19_gpt2
python main.py
