#!/bin/bash
#FLUX: --job-name=TLS-disp
#FLUX: -t=345600
#FLUX: --priority=16

pwd; hostname; date
module load conda
module load snakemake
snakemake --profiles profiles/slurm
