#!/bin/bash
#FLUX: --job-name=runs/${JOB_NAME}
#FLUX: -N=2
#FLUX: -c=16
#FLUX: --exclusive
#FLUX: --queue=guest-gpu
#FLUX: -t=86400
#FLUX: --priority=16

source /home/garbus/.bashrc
conda activate trade
redis_password="longredispassword"
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
port=6380
ip_head=$ip:$port
export ip_head
echo "IP Head: $ip_head"
echo "STARTING HEAD at $node_1"
srun --nodes=1 --ntasks=1 -w "$node_1" --gres=gpu:TitanX:8 \
    ray start --head --node-ip-address="$ip" \
         --port=$port \
         --redis-password="$redis_password"\
         --node-manager-port=6800 \
         --object-manager-port=6801 \
         --ray-client-server-port=20001 \
         --redis-shard-ports=6802 \
         --min-worker-port=20002 \
         --max-worker-port=29999 \
         --block &
sleep 30
worker_num=$((SLURM_JOB_NUM_NODES - 1)) #number of nodes other than the head node
for ((i = 1; i <= worker_num; i++)); do
    node_i=${nodes_array[$i]}
    echo "STARTING WORKER $i at $node_i"
    srun --nodes=1 --ntasks=1 -w "$node_i" --gres=gpu:TitanX:8 \
        ray start --address "$ip_head" \
            --redis-password="$redis_password"\
            --node-manager-port=6800 \
            --object-manager-port=6801 \
            --min-worker-port=20002 \
            --max-worker-port=29999 \
            --block &
done
sleep 30
${COMMAND_PLACEHOLDER} --second-cluster
