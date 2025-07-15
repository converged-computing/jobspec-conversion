#!/bin/bash
#FLUX: --job-name=salted-onion-4912
#FLUX: -c=10
#FLUX: --queue=kipac
#FLUX: --urgency=16

source ~/setup.sh
conda activate wfsim
python simtest.py --atmSeed $SLURM_ARRAY_TASK_ID --outdir heightPsfws --outfile outh_psfws_$SLURM_ARRAY_TASK_ID.pkl --usePsfws
python simtest.py --atmSeed $SLURM_ARRAY_TASK_ID --outdir heightRand --outfile outh_rand_$SLURM_ARRAY_TASK_ID.pkl --useRand
