#!/bin/bash
#FLUX: --job-name=dinosaur-hobbit-7368
#FLUX: -c=2
#FLUX: --priority=16

SOURCE_PATH="${HOME}/rpl-workshop"
RUNS_PATH="${HOME}/rpl-workshop/runs"
DATA_PATH="/local_storage/datasets/CUB_20"
for learning_rate in .001 .01; do
for weight_decay in .001 .00001; do
for batch_size in 32 64; do
sbatch << HERE
echo "JOB: \${SLURM_JOB_ID}"
echo "HOST: \$(hostname)"
echo "SUBMITTED: $(date)"
echo "STARTED: \$(date)"
echo ""
nvidia-smi
source "${HOME}/miniconda3/etc/profile.d/conda.sh"
conda activate workshop
python -m workshop.train \
    --runpath "${RUNS_PATH}" \
    --datapath "${DATA_PATH}" \
    --batch_size "${batch_size}" \
    --learning_rate "${learning_rate}" \
    --weight_decay "${weight_decay}" \
    --number_epochs 20 \
    --number_workers 2 \
    --device 'cuda'
EXIT_CODE="\${?}"
if [ "\${EXIT_CODE}" -eq 0 ]; then
  # Success
else
  # Error (cleanup?)
fi
exit "\${EXIT_CODE}"
HERE
done
done
done
