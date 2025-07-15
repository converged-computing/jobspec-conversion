#!/bin/bash
#FLUX: --job-name=${RUN_CONFIG_PREFIX}
#FLUX: -c=2
#FLUX: --priority=16

RUNS_PATH="${HOME}/rpl-workshop/runs"
DATA_PATH="/local_storage/datasets/CUB_20"
RUN_CONFIG_PREFIX="array.$(date +'%F_%T.%N')"
SLURM_MAX_TASKS=2
mkdir -p "${RUNS_PATH}/queue" "${RUNS_PATH}/error"
SLURM_ARRAY_TASK_ID=0
for learning_rate in .001 .01; do
for weight_decay in .001 .00001; do
for batch_size in 32 64; do
let "SLURM_ARRAY_TASK_ID++"
cat << HERE > "${RUNS_PATH}/queue/${RUN_CONFIG_PREFIX}.${SLURM_ARRAY_TASK_ID}.yaml"
paths:
    runs: ${RUNS_PATH}
    data: ${DATA_PATH}
dataloader:
    number_workers: 2
    batch_size: ${batch_size}
optimizer:
    learning_rate: ${learning_rate}
    weight_decay: ${weight_decay}
    number_epochs: 20
session:
    device: cuda
HERE
done
done
done
sbatch << HERE
echo "JOB: \${SLURM_ARRAY_JOB_ID}"
echo "TASK: \${SLURM_ARRAY_TASK_ID}"
echo "HOST: \$(hostname)"
echo "SUBMITTED: $(date)"
echo "STARTED: \$(date)"
echo ""
nvidia-smi
source "${HOME}/miniconda3/etc/profile.d/conda.sh"
conda activate workshop
python -m workshop.train_yaml \
    "${RUNS_PATH}/queue/${RUN_CONFIG_PREFIX}.\${SLURM_ARRAY_TASK_ID}.yaml"
EXIT_CODE="\${?}"
if [ "\${EXIT_CODE}" -eq 0 ]; then
  # Success
  rm "${RUNS_PATH}/queue/${RUN_CONFIG_PREFIX}.\${SLURM_ARRAY_TASK_ID}.yaml"
else
  # Error
  mv "${RUNS_PATH}/queue/${RUN_CONFIG_PREFIX}.\${SLURM_ARRAY_TASK_ID}.yaml" \
     "${RUNS_PATH}/error/${RUN_CONFIG_PREFIX}.\${SLURM_ARRAY_TASK_ID}.yaml"
fi
exit "\${EXIT_CODE}"
HERE
