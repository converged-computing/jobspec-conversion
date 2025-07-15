#!/bin/bash
#FLUX: --job-name=realign
#FLUX: --queue=standard
#FLUX: -t=172800
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda init bash
conda activate snake
module load Bioinformatics
module load samtools
snakemake -s realign.smk --unlock
snakemake -s realign.smk --rerun-incomplete --cores 12
