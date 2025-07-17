#!/bin/bash
#FLUX: --job-name=bumfuzzled-egg-2006
#FLUX: -c=10
#FLUX: --queue=kipac
#FLUX: -t=7200
#FLUX: --urgency=16

source ~/setup.sh
conda activate wfsim
python simtest.py --atmSeed $SLURM_ARRAY_TASK_ID --outdir heightPsfws --outfile outh_psfws_$SLURM_ARRAY_TASK_ID.pkl --usePsfws
python simtest.py --atmSeed $SLURM_ARRAY_TASK_ID --outdir heightRand --outfile outh_rand_$SLURM_ARRAY_TASK_ID.pkl --useRand
