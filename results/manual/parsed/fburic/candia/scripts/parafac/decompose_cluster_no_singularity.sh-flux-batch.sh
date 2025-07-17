#!/bin/bash
#FLUX: --job-name=conspicuous-leg-5261
#FLUX: -t=604800
#FLUX: --urgency=16

if [ "$#" -lt 2 ]; then
    echo "[ERROR] Correct syntax:"
	echo $0 " EXPERIMENT_CONFIG_FILE N_PARALLEL_DECOMP_PER_GPU"
	exit 1
fi
N_PAR_DECOMP=$2
CUDA_VISIBLE_DEVICES=0
source scripts/parafac/start_mps.sh
snakemake -j ${N_PAR_DECOMP} --keep-going -s scripts/parafac/decompose_parafac.Snakefile \
  --config npartitions=${SLURM_ARRAY_TASK_COUNT} partition=${SLURM_ARRAY_TASK_ID} device=0 \
  --configfile $1
source scripts/parafac/stop_mps.sh
