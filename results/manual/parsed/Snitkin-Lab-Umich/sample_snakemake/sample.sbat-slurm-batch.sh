#!/bin/bash
#FLUX: --job-name=sample_snakemake
#FLUX: --queue=standard
#FLUX: -t=36000
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
echo $SLURM_SUBMIT_DIR
snakemake --latency-wait 20 --profile config -s snakefile
