#!/bin/bash
#FLUX: --job-name=fuzzy-taco-2674
#FLUX: -n=8
#FLUX: -t=604800
#FLUX: --urgency=16

if [ "$#" -lt 2 ]; then
    echo "[ERROR] Correct syntax:"
	echo $0 " EXPERIMENT_CONFIG_FILE N_PARALLEL_DECOMP_PER_GPU"
	exit 1
fi
N_PAR_DECOMP=$2
pipe_id=$(uuidgen)
singularity exec --nv candia.sif /bin/bash -c \
  "CUDA_VISIBLE_DEVICES=0 \
  && source scripts/parafac/start_mps.sh ${pipe_id} \
  && snakemake -j ${N_PAR_DECOMP} --nolock --forceall --keep-going \
  -s scripts/parafac/decompose_parafac.Snakefile \
  --config npartitions=${SLURM_ARRAY_TASK_COUNT} partition=${SLURM_ARRAY_TASK_ID} pipe_id=${pipe_id} \
  --configfile $1 \
  && source scripts/parafac/stop_mps.sh"
