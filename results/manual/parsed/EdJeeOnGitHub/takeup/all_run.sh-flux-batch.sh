#!/bin/bash
#FLUX: --job-name=gassy-avocado-9290
#FLUX: -c=8
#FLUX: -t=36000
#FLUX: --urgency=16

LATEST_VERSION=101
VERSION=${1:-$LATEST_VERSION} # Get version from command line if provided
CMDSTAN_ARGS="--cmdstanr"
SLURM_INOUT_DIR="/project/akaring/takeup-data/data/stan_analysis_data"
ITER=800
echo "Version: $VERSION"
echo "Task ID: $SLURM_ARRAY_TASK_ID"
if [[ -v IN_SLURM ]]; then
  echo "Running in SLURM..."
  module load -f midway2 gdal/2.4.1 udunits/2.2 proj/6.1 cmake R/4.2.0
  OUTPUT_ARGS=" --output-path=${SLURM_INOUT_DIR}"
  POSTPROCESS_INOUT_ARGS=" --input-path=${SLURM_INOUT_DIR} --output-path=${SLURM_INOUT_DIR}"
  CORES=$SLURM_CPUS_PER_TASK
  echo "Running with ${CORES} cores."
  echo "INOUT ARGS: ${POSTPROCESS_INOUT_ARGS}."
else
  OUTPUT_ARGS="--output-path=data/stan_analysis_data"
  POSTPROCESS_INOUT_ARGS=
  CORES=8
fi
STAN_THREADS=$((SLURM_CPUS_PER_TASK / 4))
fit_model () {
  Rscript --no-save \
    --no-restore \
    --verbose \
    run_takeup.R takeup fit \
    --models=${1} \
    ${CMDSTAN_ARGS} \
    ${OUTPUT_ARGS} \
    --threads=${STAN_THREADS} \
    --outputname=dist_fit${VERSION} \
    --num-mix-groups=1 \
    --chains=4 \
    --iter=${ITER} \
    --sequential > temp/log/output-${1}-fit${VERSION}.txt 2>&1
}
source quick_postprocess.sh
models=(
   "STRUCTURAL_LINEAR_U_SHOCKS_PHAT_MU_REP"
   "STRUCTURAL_LINEAR_U_SHOCKS_PHAT_MU_REP_HIER_FOB"
   "STRUCTURAL_LINEAR_U_SHOCKS_PHAT_MU_REP_HIER_FIXED_FOB"
)
model=${models[${SLURM_ARRAY_TASK_ID}]}
rf_model=()
struct_model=()
fit_model ${model}
