#!/bin/bash
#FLUX: --job-name=chienlab-tnseq-ba
#FLUX: -n=24
#FLUX: --queue=cpu
#FLUX: -t=21600
#FLUX: --urgency=16

date;hostname;pwd
module load miniconda/22.11.1-1
conda activate /work/pi_pchien_umass_edu/berent/chienlab-tnseq/conda-tnseq
snakemake -q rules --profile profiles/default
date
