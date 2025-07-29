#!/bin/bash
#FLUX --job-name=reclusive-underoos-7369
#FLUX -t=259200
#FLUX --urgency=16

echo `hostname`
wdir=/projects/sequence_analysis/vol3/bizon/scigraph_cord
cd $wdir
conda activate translator
python co_occur.py output $SLURM_ARRAY_TASK_ID 200
