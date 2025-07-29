#!/bin/bash
#SBATCH --job-name=takeup
#SBATCH --output=temp/log/takeup-%j.log
#SBATCH --error=temp/log/takeup-%j.log
#SBATCH --mail-user=edjee96@gmail.com
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=4G
#SBATCH --time=10:00:00
#SBATCH --array=0-4

LATEST_VERSION=96
VERSION=${1:-$LATEST_VERSION} # Get version from command line if provided
CMDSTAN_ARGS="--cmdstanr"
SLURM_INOUT_DIR="data/stan_analysis_data"
ITER=400
if [[ -v IN_SLURM ]]; then
  echo "Running in SLURM..."
  module load -f midway2 gdal/2.4.1 udunits/2.2 proj/6.1 cmake R/4.2.0
  OUTPUT_ARGS="--output-path=${SLURM_INOUT_DIR}"
  POSTPROCESS_INOUT_ARGS="--input-path=${SLURM_INOUT_DIR} --output-path=${SLURM_INOUT_DIR}"
  CORES=$SLURM_CPUS_PER_TASK
  echo "Running with ${CORES} cores."
  echo "INOUT ARGS: ${POSTPROCESS_INOUT_ARGS}."
else
  OUTPUT_ARGS="--output-path=data/stan_analysis_data"
  POSTPROCESS_INOUT_ARGS=
  CORES=8
fi
models=(
  "STRUCTURAL_LINEAR_U_SHOCKS_PHAT_MU_REP_HIGH_SD_WTP_VAL"
  "STRUCTURAL_LINEAR_U_SHOCKS_PHAT_MU_REP_HIGH_MU_WTP_VAL"
  "STRUCTURAL_LINEAR_U_SHOCKS_PHAT_MU_REP_NO_WTP_SUBMODEL"
  "STRUCTURAL_LINEAR_U_SHOCKS_PHAT_MU_REP_NO_BELIEFS_SUBMODEL"
  "STRUCTURAL_LINEAR_U_SHOCKS_PHAT_MU_REP_NO_SUBMODELS"
)
model=${models[$SLURM_ARRAY_TASK_ID]} # get the model for this task
STAN_THREADS=$((${CORES} / 4))
Rscript --no-save \
  --no-restore \
  --verbose \
  run_takeup.R takeup fit \
  --models=${model} \
  ${CMDSTAN_ARGS} \
  ${OUTPUT_ARGS} \
  --update-output \
  --threads=${STAN_THREADS} \
  --outputname=dist_fit${VERSION} \
  --num-mix-groups=1 \
  --chains=4 \
  --iter=${ITER} \
  --sequential > temp/log/output-${model}-fit${VERSION}.txt 2>&1
