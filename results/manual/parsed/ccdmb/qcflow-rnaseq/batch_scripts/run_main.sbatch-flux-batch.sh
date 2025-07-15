#!/bin/bash
#FLUX: --job-name=delicious-lemur-9557
#FLUX: -c=2
#FLUX: --queue=work
#FLUX: -t=86400
#FLUX: --priority=16

module load nextflow/22.10.0
module load singularity/3.11.4-slurm
nextflow run -resume -profile singularity,pawsey_setonix -r main ccdmb/qcflow-rnaseq \
  --workflow align \
  --aligner hisat \
  --sjOverhang 149 \
  --genome "$PWD/genome/Morex_pseudomolecules_v2.fasta" \
  --genes "$PWD/genome/Morex.gtf" \
  --output_dir results \
  --library_name 1,6 \
  --index_dir "$PWD/index/hisat_index/" \
  --hisat_prefix hisat_index \
  --fastq_dir "$PWD/test/*R{1,2}.fastq.gz" \
  --strandedness RF
