#!/bin/bash
#FLUX: --job-name=takeup_pp
#FLUX: --queue=broadwl
#FLUX: -t=14400
#FLUX: --urgency=16

LATEST_VERSION=62
VERSION=${1:-$LATEST_VERSION} # Get version from command line if provided
CMDSTAN_ARGS="--cmdstanr"
SLURM_INOUT_DIR=~/scratch-midway2
if [[ -v IN_SLURM ]]; then
  echo "Running in SLURM..."
  module load midway2 gdal/2.4.1 udunits cmake R/4.2.0
  OUTPUT_ARGS="--output-path=${SLURM_INOUT_DIR}"
  POSTPROCESS_INOUT_ARGS="--input-path=${SLURM_INOUT_DIR} --output-path=${SLURM_INOUT_DIR}"
  CORES=$SLURM_CPUS_PER_TASK
  echo "Running with ${CORES} cores."
  echo "INOUT ARGS: ${POSTPROCESS_INOUT_ARGS}."
else
  OUTPUT_ARGS="--output-path=data/stan_analysis_data"
  POSTPROCESS_INOUT_ARGS=
  CORES=12
fi
Rscript ./postprocess_dist_fit.R ${VERSION} ${POSTPROCESS_INOUT_ARGS} --cores=1 --load-from-csv
