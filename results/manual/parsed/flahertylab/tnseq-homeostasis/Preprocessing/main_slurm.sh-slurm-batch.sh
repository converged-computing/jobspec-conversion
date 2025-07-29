#!/bin/bash
#FLUX: --job-name=chienlab-tnseq-ba
#FLUX: -n=12
#FLUX: --queue=cpu
#FLUX: -t=21600
#FLUX: --urgency=16

date;hostname;pwd
module load miniconda/22.11.1-1
conda activate chienlab-tnseq
snakemake all --cores
date
