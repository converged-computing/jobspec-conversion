#!/bin/bash
#FLUX: --job-name=mutualinfo
#FLUX: --queue=general
#FLUX: -t=5400
#FLUX: --urgency=16

ml use /opt/insy/modulefiles;
ml load cuda/11.0;
ml load cudnn/11.0-8.0.3.33;
DATASET=$1;
NPERM=10000;
python src/PoE/kldivergence_parallel.py './configs/best-models/'$DATASET'_poe.yaml' $2;
