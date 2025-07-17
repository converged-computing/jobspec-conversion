#!/bin/bash
#FLUX: --job-name=ariba
#FLUX: --queue=standard
#FLUX: -t=36000
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
echo $SLURM_SUBMIT_DIR
snakemake --latency-wait 90 --profile config -s snakefile
