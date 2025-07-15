#!/bin/bash
#FLUX: --job-name=phat-snack-4704
#FLUX: -c=32
#FLUX: -t=432000
#FLUX: --urgency=16

set -euo pipefail
num_cpus=${SLURM_CPUS_PER_TASK}
bytes_of_memory=$((${SLURM_MEM_PER_NODE}*1000000 / 4)) #MB -> bytes
echo "requested ${num_cpus} cores and ray is told ${bytes_of_memory} memory available"
network_size=1e5
user_fraction=1.0
param_prior_noise_factor=0.25
EXP_NAME="noda_u100_prior"
budget=0
OUTPUT_DIR="output"
output_path="${OUTPUT_DIR}/${EXP_NAME}_${budget}"
stdout="${output_path}/stdout"
stderr="${output_path}/stderr"
mkdir -p "${output_path}"
echo "output to be found in: ${output_path}, stdout in $stdout, stderr in $stderr "
cp batch_scripts/run_u100_prior.sh ${output_path}
python3 joint_iterated_forward_assimilation.py \
  --user-network-user-fraction=${user_fraction} \
  --constants-output-path=${output_path} \
  --network-node-count=${network_size} \
  --parallel-flag \
  --parallel-memory=${bytes_of_memory} \
  --parallel-num-cpus=${num_cpus} \
  --params-learn-transition-rates \
  --params-learn-transmission-rate \
  --params-transmission-rate-noise=${param_prior_noise_factor} \
  --prior-run\
  >${stdout} 2>${stderr}
