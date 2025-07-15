#!/bin/bash
#FLUX: --job-name=test
#FLUX: -N=3
#FLUX: -n=3
#FLUX: -c=24
#FLUX: -t=300
#FLUX: --priority=16

module load gcc
module load python/3.8  
redis_password=$(uuidgen)
export redis_password
nodes=$(scontrol show hostnames "$SLURM_JOB_NODELIST") # Getting the node names
nodes_array=($nodes)
node_1=${nodes_array[0]}
ip=$(srun --nodes=1 --ntasks=1 -w "$node_1" hostname --ip-address) # making redis-address
port=6379
ip_head=$ip:$port
export ip_head
echo "IP Head: $ip_head"
echo "STARTING HEAD at $node_1"
srun --nodes=1 --ntasks=1 -w "$node_1" \
  ray start --head --node-ip-address="$ip" --port=$port --redis-password="$redis_password" --block &
  sleep 30
worker_num=$((SLURM_JOB_NUM_NODES - 1)) #number of nodes other than the head node
for ((i = 1; i <= worker_num; i++)); do
  node_i=${nodes_array[$i]}
    echo "STARTING WORKER $i at $node_i"
    srun --nodes=1 --ntasks=1 -w "$node_i" ray start --address "$ip_head" --redis-password="$redis_password" --block &
    sleep 5
  done
python3 -u script.py "$SLURM_CPUS_PER_TASK"
