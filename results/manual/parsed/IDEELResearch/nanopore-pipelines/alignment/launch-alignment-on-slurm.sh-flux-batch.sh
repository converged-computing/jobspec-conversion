#!/bin/bash
#FLUX: --job-name=reclusive-muffin-7848
#FLUX: --urgency=16

module load samtools
snakemake -s do-alignment-ngmlr.py --cluster "sbatch -n5 -t 4-00:00:00 --mem 7Gb " -j 8
