#!/bin/bash
#FLUX: --job-name=Nextflow-master-trinity
#FLUX: --queue=longq
#FLUX: -t=345600
#FLUX: --priority=16

module load singularity  # only needed if containers are yet to be downloaded
module load nextflow
nextflow run marcodelapierre/trinity-nf \
  --reads='reads_{1,2}.fq.gz' \
  -profile zeus --slurm_account='director2172' \
  -name nxf-${SLURM_JOB_ID} \
  -with-trace trace-${SLURM_JOB_ID}.txt \
  -with-report report-${SLURM_JOB_ID}.html
