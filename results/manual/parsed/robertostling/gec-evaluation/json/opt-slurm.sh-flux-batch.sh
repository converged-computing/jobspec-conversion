#!/bin/bash
#FLUX: --job-name=opt
#FLUX: --urgency=16

export HF_DATASETS_CACHE='/cephyr/NOBACKUP/groups/smnlp/.hg_cache'
export TRANSFORMERS_CACHE='/cephyr/NOBACKUP/groups/smnlp/.hg_cache'

export HF_DATASETS_CACHE="/cephyr/NOBACKUP/groups/smnlp/.hg_cache"
export TRANSFORMERS_CACHE="/cephyr/NOBACKUP/groups/smnlp/.hg_cache"
module load Python/3.9.5-GCCcore-10.3.0
module load CUDA/11.3.1
module load  cuDNN/8.2.1.32-CUDA-11.3.1
source  /cephyr/NOBACKUP/groups/smnlp/working_env/bin/activate
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
python -u opt-annotate.py "$@"
