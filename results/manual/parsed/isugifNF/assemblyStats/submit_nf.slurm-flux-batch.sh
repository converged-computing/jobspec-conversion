#!/bin/bash
#FLUX: --job-name=NF_assemblyStat
#FLUX: -t=86400
#FLUX: --urgency=16

module load nextflow
NEXTFLOW=nextflow
cd ${SLURM_SUBMIT_DIR}
${NEXTFLOW} run main.nf \
  --genome "8_consensus.fasta" \
  -profile singularity,ceres \
  -resume
