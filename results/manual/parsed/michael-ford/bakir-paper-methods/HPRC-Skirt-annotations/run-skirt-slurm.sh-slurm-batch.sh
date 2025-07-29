#!/bin/bash
#FLUX: --job-name=run-skirt
#FLUX: -c=5
#FLUX: -t=86400
#FLUX: --urgency=16

export TMPDIR='/lscratch/$SLURM_JOB_ID'

module load nextflow
export TMPDIR=/lscratch/$SLURM_JOB_ID
nextflow run run-skirt.nf \
-profile biowulf \
