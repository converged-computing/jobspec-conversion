#!/bin/bash
#FLUX: --job-name=bf_picrust
#FLUX: --queue=Intel6240
#FLUX: -t=28800
#FLUX: --priority=16

source activate picrust2
cd /hpcstor6/scratch01/p/patrick.kearns/Bullfrog_nut_enrich
picrust2_pipeline.py -s rep_seqs/dna-sequences.fasta -o picrust_norm -i asv_table/feature-table.biom
picrust2_pipeline.py -s rep_seqs/dna-sequences.fasta -o picrust_no_norm -i asv_table/feature-table.biom --skip_norm
