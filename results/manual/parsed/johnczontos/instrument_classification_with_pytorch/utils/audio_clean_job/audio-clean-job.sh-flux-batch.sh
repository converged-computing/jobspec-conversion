#!/bin/bash
#FLUX: --job-name=audio-clean
#FLUX: --priority=16

module load cuda/11.7 sox
cd /nfs/guille/eecs_research/soundbendor/zontosj/instrument_classification_with_pytorch/data/rwc_all
/nfs/guille/eecs_research/soundbendor/zontosj/opt/bin/audio-clean.sh
cd clean
/nfs/guille/eecs_research/soundbendor/zontosj/opt/bin/audio-split.sh
