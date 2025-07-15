#!/bin/bash
#FLUX: --job-name=paragraph_sentiment
#FLUX: -c=2
#FLUX: -t=21600
#FLUX: --urgency=16

module purge
module load python3/intel/3.5.3
python3 get_ckt_yr_from_case.py
