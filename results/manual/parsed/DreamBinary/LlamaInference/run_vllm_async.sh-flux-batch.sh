#!/bin/bash
#FLUX: --job-name=scruptious-soup-3842
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=gpu_4090
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export NCCL_IB_DISABLE='0'
export NCCL_IB_HCA='mlx5_bond_0'
export NCCL_SOCKET_IFNAME='bond0'
export NCCL_IB_GID_INDEX='3'

module load anaconda/2022.10
module load cuda/12.2
source activate aa
X_LOG_DIR="log_${SLURM_JOB_ID}"
X_GPU_LOG="${X_LOG_DIR}/gpu.log"
mkdir "${X_LOG_DIR}"
function gpus_collection(){
   sleep 15
   process=`ps -ef | grep python | grep $USER | grep -v "grep" | wc -l`
   while [[ "${process}" > "0" ]]; do
      sleep 1
      nvidia-smi >> "${X_GPU_LOG}" 2>&1
      echo "process num:${process}" >> "${X_GPU_LOG}" 2>&1
      process=`ps -ef | grep python | grep $USER | grep -v "grep" | wc -l`
   done
}
gpus_collection &
export NCCL_DEBUG=INFO
export NCCL_IB_DISABLE=0
export NCCL_IB_HCA=mlx5_bond_0
export NCCL_SOCKET_IFNAME=bond0
export NCCL_IB_GID_INDEX=3
redis_password=5241590000000000
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
sleep 10
worker_num=$((SLURM_JOB_NUM_NODES - 1)) #number of nodes other than the head node
for ((i = 1; i <= worker_num; i++)); do
  node_i=${nodes_array[$i]}
  echo "STARTING WORKER $i at $node_i"
  srun --nodes=1 --ntasks=1 -w "$node_i" ray start --address "$ip_head" --redis-password="$redis_password" --block &
  sleep 5
done
python script/main.py --dataset data/scrambled_sampled_dataset.json --model Llama-2-70b-hf --run vllm_async --redis_password "$redis_password" --num_gpus 16
