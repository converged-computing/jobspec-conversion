#!/bin/bash
#FLUX: --job-name=time_blast
#FLUX: -t=86400
#FLUX: --priority=16

module load nextflow
module load blast       # or ncbi
nextflow run main.nf \
  --db "/path/to/nt.fasta" \
  --query "*.fasta" \
  --options '-outfmt 6 -num_alignments 1'
  --threads 50
