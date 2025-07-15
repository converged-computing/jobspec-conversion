#!/bin/bash
#FLUX: --job-name=Nextflow-master-nanopore
#FLUX: --queue=workq
#FLUX: -t=86400
#FLUX: --urgency=16

module load nextflow
nextflow run marcodelapierre/nanopore-nf \
  --read_dir='sample6' --seqid='D10930.1,MK116873.1' \
  -profile zeus --slurm_account='pawsey0281' \
  -name nxf-${SLURM_JOB_ID} \
  -with-trace trace-${SLURM_JOB_ID}.txt \
  -with-report report-${SLURM_JOB_ID}.html
