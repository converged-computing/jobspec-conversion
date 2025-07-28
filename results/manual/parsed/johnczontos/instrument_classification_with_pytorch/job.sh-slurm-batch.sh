#!/bin/bash
#FLUX: --job-name=MIC
#FLUX: -c=6
#FLUX: --queue=soundbendor
#FLUX: -t=86400
#FLUX: --urgency=16

module load python/3.10 cuda/11.7 sox
source env/bin/activate
python run_model.py data/rwc_all/clean/split
