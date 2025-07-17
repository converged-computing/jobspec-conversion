#!/bin/bash
#FLUX: --job-name=haplotype_calling_pipeline
#FLUX: -t=2073600
#FLUX: --urgency=16

echo "$SLURM_ARRAY_TASK_ID"
snakemake --cores 12 --stats output/stats
