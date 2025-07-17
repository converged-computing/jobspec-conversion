#!/bin/bash
#FLUX: --job-name=anxious-bits-5033
#FLUX: -c=28
#FLUX: --queue=workq
#FLUX: -t=86400
#FLUX: --urgency=16

module load nextflow/19.01.0.5050-bin
nextflow run -resume -profile pawsey_zeus ./main.nf \
    --reference mitSN15.fasta \
    --seed mitSN15.fasta \
    --asm_table reads.tsv \
    --filter_table reads.tsv \
    --read_length 125 \
    --insert_size 600
