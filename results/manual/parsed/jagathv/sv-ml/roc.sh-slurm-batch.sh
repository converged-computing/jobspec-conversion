#!/bin/bash
#FLUX: --job-name=anxious-lentil-0104
#FLUX: --queue=general
#FLUX: -t=360000
#FLUX: --urgency=16

module load Python
module load matplotlib
python roc_prc_gen.py [input file] [output file] 
