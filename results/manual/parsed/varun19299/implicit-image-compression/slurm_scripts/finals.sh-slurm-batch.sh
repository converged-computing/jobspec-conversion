#!/bin/bash
#FLUX: --job-name=finals
#FLUX: -c=4
#FLUX: --queue=batch_default
#FLUX: -t=43200
#FLUX: --urgency=16

echo "== Starting run at $(date)"
echo "== Job ID: ${SLURM_JOB_ID}"
echo "== Node list: ${SLURM_NODELIST}"
echo "== Submit dir: ${SLURM_SUBMIT_DIR}"
echo "== Time limit: ${SBATCH_TIMELIMIT}"
nvidia-smi
module load cuda/10.2 anaconda/wml
source ~/.zshrc
conda activate torch1.7_py38
if [ $SLURM_ARRAY_TASK_ID -eq 0 ]; then
  while true
   do
       nvidia-smi | cat >"slurm_outputs/nvidia-smi-${SLURM_JOB_NAME}.${SLURM_JOB_ID}.out"
       sleep 0.1
  done &
fi
density_ll=(
    0.01
    0.02
    0.05
    0.10
    0.20
    0.25
    0.30
    0.35
    0.40
    0.45
    0.50
    0.55
    0.60
    0.65
    0.70
    0.75
    0.80
    0.85
    0.90
    0.95
)
for i in "${density_ll[@]}"; do
    if [ ${1} == "building" ] ||  [ ${1} == "bridge" ]; then
       make finals.compress.${1} DENSITY=$i KWARGS="mlp.hidden_size=182 quant.bits=9"
    else
       make finals.compress.${1} DENSITY=$i
    fi
done
