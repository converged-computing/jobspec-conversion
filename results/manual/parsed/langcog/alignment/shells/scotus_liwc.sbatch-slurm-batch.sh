#!/bin/bash
#FLUX: --job-name=SCOTUS79
#FLUX: -t=14400
#FLUX: --urgency=16

cd ~gdoyle/seetweet/alignment/alignment/
module load python/3.3.2
python CHILDES_analysis3.py -r -S -R
