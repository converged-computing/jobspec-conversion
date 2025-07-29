#!/bin/bash
#FLUX --job-name=spicy-ricecake-7151
#FLUX -n=5
#FLUX -t=345600
#FLUX --urgency=16

module load samtools
snakemake -s do-alignment-ngmlr.py --cluster "sbatch -n5 -t 4-00:00:00 --mem 7Gb " -j 8
