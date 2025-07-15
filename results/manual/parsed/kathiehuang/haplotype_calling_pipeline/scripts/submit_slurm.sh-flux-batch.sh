#!/bin/bash
#FLUX: --job-name=conspicuous-puppy-5594
#FLUX: --urgency=16

echo "$SLURM_ARRAY_TASK_ID"
snakemake --cores 12 --stats output/stats
