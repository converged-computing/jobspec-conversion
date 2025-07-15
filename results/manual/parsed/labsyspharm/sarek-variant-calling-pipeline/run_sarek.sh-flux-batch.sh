#!/bin/bash
#FLUX: --job-name=swampy-lizard-9771
#FLUX: --priority=16

set -eu
module load java/jdk-11.0.11
set -x
nextflow run nf-core/sarek -r 3.4.0 -profile singularity \
  -params-file nf-params.json -c ~/o2.config \
  -with-trace -with-report "report_${SLURM_JOB_ID}.html" \
  -with-timeline "timeline_${SLURM_JOB_ID}.html" \
  "$@"
