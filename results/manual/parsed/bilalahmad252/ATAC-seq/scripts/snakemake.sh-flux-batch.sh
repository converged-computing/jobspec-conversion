#!/bin/bash
#FLUX: --job-name=snakemake
#FLUX: -c=4
#FLUX: -t=86400
#FLUX: --urgency=16

cd /homes/bilala/BedTools/Chipseq_2024/scripts/snake_file_yam
snakemake --use-conda --cores 4 -s snake_file_with_yaml.smk --latency-wait 100
