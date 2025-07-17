#!/bin/bash
#FLUX: --job-name=dinosaur-kerfuffle-0090
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=rosa.p
#FLUX: -t=28800
#FLUX: --urgency=16

redis_password=$(uuidgen)
export redis_password
nodes=$(scontrol show hostnames "$SLURM_JOB_NODELIST") # Getting the node names
nodes_array=($nodes)
node_1=${nodes_array[0]}
ip=$(srun --nodes=1 --ntasks=1 -w "$node_1" hostname --ip-address) # making redis-address
if [[ "$ip" == *" "* ]]; then
  IFS=' ' read -ra ADDR <<< "$ip"
  if [[ ${#ADDR[0]} -gt 16 ]]; then
    ip=${ADDR[1]}
  else
    ip=${ADDR[0]}
  fi
  echo "IPV6 address detected. We split the IPV4 address as $ip"
fi
port=6379
ip_head=$ip:$port
export ip_head
echo "IP Head: $ip_head"
echo "STARTING HEAD at $node_1"
srun --nodes=1 --ntasks=1 -w "$node_1" ray start --head --node-ip-address="$ip" --port=$port --redis-password="$redis_password" --include-dashboard=True --dashboard-host="0.0.0.0" --num-cpus 128 --block &
sleep 20
worker_num=$((SLURM_JOB_NUM_NODES - 1)) #number of nodes other than the head node
for ((i = 1; i <= worker_num; i++)); do
  node_i=${nodes_array[$i]}
  this_node_ip=$(srun --nodes=1 --ntasks=1 -w "$node_i" hostname --ip-address)
  if [[ "$this_node_ip" == *" "* ]]; then
  IFS=' ' read -ra ADDR <<<"$this_node_ip"
  if [[ ${#ADDR[0]} -gt 16 ]]; then
    this_node_ip=${ADDR[1]}
  else
    this_node_ip=${ADDR[0]}
  fi
  echo "IPV6 address detected. We split the IPV4 address as $head_node_ip"
  fi
  echo "STARTING WORKER $i at $node_i"
  srun --nodes=1 --ntasks=1 -w "$node_i" ray start --address "$ip_head" --redis-password="$redis_password" --node-ip-address="$this_node_ip" --num-cpus 128 --block &
  sleep 5
done
cd ./OPFBenchmarkFramework
python -W ignore main_a2c_qmarket.py
python -W ignore main_a2c_ecodispatch.py
