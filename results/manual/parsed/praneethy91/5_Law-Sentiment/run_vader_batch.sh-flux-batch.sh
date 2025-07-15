#!/bin/bash
#FLUX: --job-name=paragraph_sentiment
#FLUX: -c=2
#FLUX: -t=356400
#FLUX: --urgency=16

module purge
module load python3/intel/3.5.3
module load nltk/3.2.2
python3 paragraph_sentiment_vader.py
