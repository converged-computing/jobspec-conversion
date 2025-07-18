#!/bin/bash
#FLUX: --job-name=nerdy-snack-6434
#FLUX: --queue=longq
#FLUX: -t=172800
#FLUX: --urgency=16

module load nextflow/19.01.0.5050-bin
module load singularity/3.3.0
nextflow run -resume \
  -profile pawsey_zeus,singularity \
  ./main.nf \
  --seqs nr_leq5000.fasta \
  --msas clusters/msa \
  --enrich_seqs enrich_seqs.fasta \
  --noremote \
  --outdir run
