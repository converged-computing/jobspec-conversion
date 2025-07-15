#!/bin/bash
#FLUX: --job-name=purple-lemur-6047
#FLUX: --priority=16

echo "$SLURM_ARRAY_TASK_ID"
snakemake --cores 12 --stats output/stats
