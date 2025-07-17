#!/bin/bash
#FLUX: --job-name=quirky-noodle-7563
#FLUX: -c=2
#FLUX: --queue=work
#FLUX: -t=86400
#FLUX: --urgency=16

module load nextflow/22.10.0
module load singularity/3.11.4-slurm
nextflow run -resume -profile singularity,pawsey_setonix -r main ccdmb/qcflow-rnaseq \
  --workflow genome-index \
  --aligner hisat-highmem \
  --genome "$PWD/genome/Morex_pseudomolecules_v2.fasta" \
  --genes "$PWD/genome/Morex.gtf" \
  --output_dir results
