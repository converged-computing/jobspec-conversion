#!/bin/bash
#FLUX: --job-name="breseq_snakemake"
#FLUX: -t=108000
#FLUX: --priority=16

bash snakemakeslurm.sh
echo Done!!!
