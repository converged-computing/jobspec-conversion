#!/bin/bash
#FLUX: --job-name=hanky-taco-0834
#FLUX: -N=2
#FLUX: -c=96
#FLUX: --queue=gpus
#FLUX: -t=1800
#FLUX: --priority=16

export NCCL_SOCKET_IFNAME='ib0'
export SRUN_CPUS_PER_TASK='$SLURM_CPUS_PER_TASK'

set -x
export NCCL_SOCKET_IFNAME="ib0"
export SRUN_CPUS_PER_TASK="$SLURM_CPUS_PER_TASK"
source /p/project/training2405/sc_venv_sbi/activate.sh
nodes=$(scontrol show hostnames "$SLURM_JOB_NODELIST")
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)
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
srun --nodes=1 --ntasks=1 -w "$head_node" \
    ray start --head --node-ip-address="$head_node_ip" --port=$port \
    --num-cpus "${SLURM_CPUS_PER_TASK}"  --block &
sleep 10
echo "------------------------------------"
worker_num=$((SLURM_JOB_NUM_NODES - 1))
for ((i = 1; i <= worker_num; i++)); do
    #export SRUN_CPUS_PER_TASK="$SLURM_CPUS_PER_TASK"
    node_i=${nodes_array[$i]}
    echo "Starting WORKER $i at $node_i"
    srun --nodes=1 --ntasks=1 -w "$node_i" \
        ray start --address "$ip_head" \
        --num-cpus "${SLURM_CPUS_PER_TASK}"  --block &
    sleep 5
done
python -u pyross_example_script.py
