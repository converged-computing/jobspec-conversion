#!/bin/bash
#FLUX: --job-name=peachy-leopard-3493
#FLUX: -c=2
#FLUX: --queue=work
#FLUX: -t=86400
#FLUX: --urgency=16

export NXF_SINGULARITY_CACHEDIR='./work'

module load nextflow/22.10.0
module load singularity/3.11.4-slurm
export NXF_SINGULARITY_CACHEDIR="./work"
NXF_ANSI_LOG=false nextflow run KristinaGagalova/pante2-legacy -r main \
  -profile pawsey_setonix,singularity \
  -resume \
  --genomes "test/*.fasta" \
  --dfam_h5 "/path/to/dfam38_full.0.h5.gz" \
  --outdir "test/results"
