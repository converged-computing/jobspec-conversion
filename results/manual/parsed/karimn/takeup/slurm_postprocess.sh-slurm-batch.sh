#!/bin/bash
#FLUX: --job-name=quick-takeup
#FLUX: -n=6
#FLUX: --queue=bigmem2
#FLUX: -t=36000
#FLUX: --urgency=16

LATEST_VERSION=95
VERSION=${1:-$LATEST_VERSION} # Get version from command line if provided
SLURM_INOUT_DIR=~/scratch-midway2
models=(
  "STRUCTURAL_LINEAR_U_SHOCKS_PHAT_MU_REP_FOB"
  )
prior_args=(
  "--prior"
  ""
)
echo "Version: $VERSION"
if [[ -v IN_SLURM ]]; then
  echo "Running in SLURM..."
  module load -f midway2 gdal/2.4.1 udunits/2.2 proj/6.1 cmake R/4.2.0
  module load -f R/4.2.0
	IN_ARG="--input-path=${SLURM_INOUT_DIR}"
	OUT_ARG="--output-path=${SLURM_INOUT_DIR}"
  echo "Running with ${CORES} cores."
  echo "INOUT ARGS: ${IN_ARG} ${OUT_ARG}."
else
	IN_ARG="--input-path=data/stan_analysis_data"
	OUT_ARG="--output-path=temp-data"
  CORES=8
fi
source quick_postprocess.sh
for prior_arg in "${prior_args[@]}"
do
	for model in "${models[@]}"
	do
	  # Within SLURM tasks
	  srun --export=all --exclusive --ntasks=1 bash -c \
	    "source quick_postprocess.sh && postprocess_model \
	      quick_ate_postprocess.R \
	      ${VERSION} \
	      ${model} \
	      ${IN_ARG} \
	      ${OUT_ARG} \
	      ${prior_arg}" &
	  srun --export=all --exclusive --ntasks=1 bash -c \
	    "source quick_postprocess.sh && postprocess_model \
	      quick_submodel_postprocess.R \
	      ${VERSION} \
	      ${model} \
	      ${IN_ARG} \
	      ${OUT_ARG} \
	      ${prior_arg}" &
	  srun --export=all --exclusive --ntasks=1 bash -c \
	    "source quick_postprocess.sh && postprocess_model \
	      quick_roc_postprocess.R \
	      ${VERSION} \
	      ${model} \
	      ${IN_ARG} \
	      ${OUT_ARG} \
	      ${prior_arg} \
	      --cluster-roc \
	      --cluster-takeup-prop \
	      --cluster-rep-return-dist" &
	done
done
wait
