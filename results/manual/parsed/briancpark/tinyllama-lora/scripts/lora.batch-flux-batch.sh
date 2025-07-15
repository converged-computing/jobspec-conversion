#!/bin/bash
#FLUX: --job-name=delicious-poo-0225
#FLUX: -c=16
#FLUX: --urgency=16

source ~/.bashrc
conda activate csc542
cd /home/bcpark/csc542-project
set_cuda_visible_devices() {
    GPU_IDS=$(nvidia-smi --query-gpu=gpu_name,index --format=csv,noheader | grep 'RTX 4060' | awk -F ', ' '{print $2}')
    CUDA_VISIBLE_DEVICES=$(echo $GPU_IDS | tr ' ' ',')
    export CUDA_VISIBLE_DEVICES
}
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
srun --nodes=1 --ntasks=1 -w "$head_node" bash -c "$(declare -f set_cuda_visible_devices); set_cuda_visible_devices"
echo "Starting HEAD at $head_node"
srun --nodes=1 --ntasks=1 -w "$head_node" \
    ray start --head --node-ip-address="$head_node_ip" --port=$port \
    --num-cpus 32 --num-gpus 1 --block &
sleep 10
worker_num=$((SLURM_JOB_NUM_NODES - 1))
for ((i = 1; i <= worker_num; i++)); do
    node_i=${nodes_array[$i]}
    srun --nodes=1 --ntasks=1 -w "$node_i" bash -c "$(declare -f set_cuda_visible_devices); set_cuda_visible_devices"
    echo "Starting WORKER $i at $node_i"
    srun --nodes=1 --ntasks=1 -w "$node_i" \
        ray start --address "$ip_head" \
        --num-cpus 32 --num-gpus 1 --block &
    sleep 5
done
echo "Workers successfully initialized!"
python3 main.py --hyperparameter-tune
