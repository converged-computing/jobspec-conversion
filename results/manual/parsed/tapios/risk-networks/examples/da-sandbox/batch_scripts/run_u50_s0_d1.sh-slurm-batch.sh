#!/bin/bash
#FLUX: --job-name=u50s0d1
#FLUX: -c=32
#FLUX: -t=432000
#FLUX: --urgency=16

set -euo pipefail
num_cpus=${SLURM_CPUS_PER_TASK}
bytes_of_memory=$((${SLURM_MEM_PER_NODE}*1000000 / 4)) #MB -> bytes
echo "requested ${num_cpus} cores and ray is told ${bytes_of_memory} memory available"
network_size=1e5
wearers=0
user_fraction=0.5
user_base_type="neighbor"
I_min_threshold=0.0
I_max_threshold=1.0
da_window=1.0
n_sweeps=1
obs_noise=1e-12
sensor_reg=1e-1
test_reg=5e-2
record_reg=1e-2
distance_threshold=0
sensor_inflation=10.0
test_inflation=3.0
record_inflation=2.0
rate_inflation=1.0
additive_inflation=0.1
param_prior_noise_factor=0.25
EXP_NAME="u50_s0_d1" #1e5 = 97942 nodes
test_budgets=(0 489 1224 2448 4897 12242 48971)  
budget=${test_budgets[${SLURM_ARRAY_TASK_ID}]}
OUTPUT_DIR="output"
output_path="${OUTPUT_DIR}/${EXP_NAME}_${budget}"
stdout="${output_path}/stdout"
stderr="${output_path}/stderr"
mkdir -p "${output_path}"
echo "output to be found in: ${output_path}, stdout in $stdout, stderr in $stderr "
cp batch_scripts/run_u50_s0_d1.sh ${output_path}
python3 joint_iterated_forward_assimilation.py \
  --user-network-user-fraction=${user_fraction} \
  --user-network-type=${user_base_type} \
  --user-network-weighted \
  --constants-output-path=${output_path} \
  --observations-noise=${obs_noise} \
  --observations-I-budget=${budget} \
  --observations-sensor-wearers=${wearers} \
  --network-node-count=${network_size} \
  --parallel-flag \
  --parallel-memory=${bytes_of_memory} \
  --parallel-num-cpus=${num_cpus} \
  --sensor-assimilation-joint-regularization=${sensor_reg} \
  --test-assimilation-joint-regularization=${test_reg} \
  --record-assimilation-joint-regularization=${record_reg} \
  --assimilation-sensor-inflation=${sensor_inflation} \
  --assimilation-test-inflation=${test_inflation} \
  --assimilation-record-inflation=${record_inflation} \
  --distance-threshold=${distance_threshold} \
  --assimilation-window=${da_window} \
  --assimilation-sweeps=${n_sweeps} \
  --params-learn-transition-rates \
  --params-learn-transmission-rate \
  --params-transmission-rate-noise=${param_prior_noise_factor} \
  --params-transmission-inflation=${rate_inflation} \
  --assimilation-additive-inflation\
  --assimilation-additive-inflation-factor=${additive_inflation}\
  --record-ignore-mass-constraint\
  >${stdout} 2>${stderr}
