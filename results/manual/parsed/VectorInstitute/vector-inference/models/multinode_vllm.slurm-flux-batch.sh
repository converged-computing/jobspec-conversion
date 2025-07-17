#!/bin/bash
#FLUX: --job-name=confused-lizard-0254
#FLUX: -c=16
#FLUX: --exclusive
#FLUX: -t=14400
#FLUX: --urgency=16

module load cuda-12.3
nvidia-smi
source ${VENV_BASE}/bin/activate
source $(dirname ${MODEL_DIR})/find_port.sh
nodes=$(scontrol show hostnames "$SLURM_JOB_NODELIST")
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)
head_node_port=$(find_available_port $head_node_ip 8080 65535)
ip_head=$head_node_ip:$head_node_port
export ip_head
echo "IP Head: $ip_head"
echo "Starting HEAD at $head_node"
srun --nodes=1 --ntasks=1 -w "$head_node" \
    ray start --head --node-ip-address="$head_node_ip" --port=$head_node_port \
    --num-cpus "${SLURM_CPUS_PER_TASK}" --num-gpus "${NUM_GPUS}" --block &
sleep 10
worker_num=$((SLURM_JOB_NUM_NODES - 1))
for ((i = 1; i <= worker_num; i++)); do
    node_i=${nodes_array[$i]}
    echo "Starting WORKER $i at $node_i"
    srun --nodes=1 --ntasks=1 -w "$node_i" \
        ray start --address "$ip_head" \
        --num-cpus "${SLURM_CPUS_PER_TASK}" --num-gpus "${NUM_GPUS}" --block &
    sleep 5
done
vllm_port_number=$(find_available_port $head_node_ip 8080 65535)
echo "Server address: http://${head_node_ip}:${vllm_port_number}/v1"
echo "http://${head_node_ip}:${vllm_port_number}/v1" > ${VLLM_BASE_URL_FILENAME}
python3 -m vllm.entrypoints.openai.api_server \
--model ${VLLM_MODEL_WEIGHTS} \
--host "0.0.0.0" \
--port ${vllm_port_number} \
--tensor-parallel-size $((NUM_NODES*NUM_GPUS)) \
--dtype ${VLLM_DATA_TYPE} \
--load-format safetensors \
--trust-remote-code \
--max-model-len 22192 \
--max-logprobs ${VLLM_MAX_LOGPROBS} 
