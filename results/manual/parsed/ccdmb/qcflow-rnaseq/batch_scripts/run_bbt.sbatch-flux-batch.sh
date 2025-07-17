#!/bin/bash
#FLUX: --job-name=buttery-nalgas-8918
#FLUX: -c=2
#FLUX: --queue=work
#FLUX: -t=86400
#FLUX: --urgency=16

module load nextflow/22.10.0
module load singularity/3.11.4-slurm
nextflow run -resume -profile singularity,pawsey_setonix ./create_bloom.nf \
  --output_dir results \
  --input_fasta "$PWD/fasta/*fasta"
