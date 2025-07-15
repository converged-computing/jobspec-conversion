#!/bin/bash
#FLUX: --job-name=nxf-small
#FLUX: --queue=workq
#FLUX: -t=3600
#FLUX: --priority=16

unset SBATCH_EXPORT
module load singularity
module load nextflow
singularity exec docker://quay.io/biocontainers/blast:2.7.1--h4422958_6 makeblastdb -in tinydb.fasta -dbtype nucl -parse_seqids
nextflow run main.nf \
  --basecalled='small.fastq' \
  --seqid='X55033.1,NC_037830.1,MG882489.1' \
  --blast_db="$(pwd)/tinydb.fasta" \
  --min_len_contig='0' \
  -profile zeus --slurm_account='pawsey0001' \
  -name nxf-${SLURM_JOB_ID}
