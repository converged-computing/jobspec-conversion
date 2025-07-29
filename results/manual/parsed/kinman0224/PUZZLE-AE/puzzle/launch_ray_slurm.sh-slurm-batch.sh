#!/bin/bash
#FLUX: --job-name=AE
#FLUX: --exclusive
#FLUX: --queue=Nvidia_A800
#FLUX: --urgency=16

export RAY_DEDUP_LOGS='0'

set -x
export RAY_DEDUP_LOGS=0
SLURM_CPUS_PER_TASK=64
SLURM_GPUS_PER_TASK=8
nodes=$(scontrol show hostnames "$SLURM_JOB_NODELIST")
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1  --cpus-per-task=8 --ntasks=1 -w "$head_node" hostname --ip-address)
if [[ "$head_node_ip" == *" "* ]]; then
IFS=' ' read -ra ADDR <<<"$head_node_ip"
if [[ ${#ADDR[0]} -gt 16 ]]; then
  head_node_ip=${ADDR[1]}
else
  head_node_ip=${ADDR[0]}
fi
echo "IPV6 address detected. We split the IPV4 address as $head_node_ip"
fi
port=6379
ip_head=$head_node_ip:$port
export ip_head
echo "IP Head: $ip_head"
echo "Starting HEAD at $head_node"
srun --nodes=1 --ntasks=1 -w "$head_node" --mem=500GB --gres=gpu:8 --cpus-per-task=8 --exclusive \
    ray start --head --node-ip-address="$head_node_ip" --port=$port \
    --num-gpus "${SLURM_GPUS_PER_TASK}" --num-cpus "${SLURM_CPUS_PER_TASK}" --block &
sleep 10
worker_num=$((SLURM_JOB_NUM_NODES - 1))
for ((i = 1; i <= worker_num; i++)); do
    node_i=${nodes_array[$i]}
    echo "Starting WORKER $i at $node_i"
    srun --nodes=1 --ntasks=1 -w "$node_i" --mem=500GB --gres=gpu:8 --cpus-per-task=8 --exclusive \
        ray start --address "$ip_head" \
        --num-gpus "${SLURM_GPUS_PER_TASK}" --num-cpus "${SLURM_CPUS_PER_TASK}" --block &
    sleep 5
done
srun --nodes=1 --ntasks=1 -w "$head_node" --gres=gpu:0 --mem-per-cpu=4G --exclusive $1
sleep 3600
echo "$(date '+%Y-%m-%d %H:%M:%S') Job ${SLURM_JOB_ID} stopped ..."
