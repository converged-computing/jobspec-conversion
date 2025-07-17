#!/bin/bash
#FLUX: --job-name=instrument
#FLUX: -c=8
#FLUX: --queue=cascades
#FLUX: -t=259200
#FLUX: --urgency=16

module load python/3.10 cuda/11.7 sox
cd /nfs/guille/eecs_research/soundbendor/zontosj/instrument_classification_with_pytorch
source env/bin/activate
python run_model.py data/rwc_all/clean/split
