#!/bin/bash
#FLUX: --job-name=picrust_analysis
#FLUX: --queue=batch,guest
#FLUX: -t=43200
#FLUX: --urgency=16

cd /work/biocore/zalsafwani/CRC_data/raw_reads/qiime2/second_analysis/picrust
module load picrust2/2.4
sed '1d' feature-table.tsv > fixed-feature-table.tsv
picrust2_pipeline.py -s ../../exports/rep-seqs/dna-sequences.fasta -i fixed-feature-table.tsv -o results
