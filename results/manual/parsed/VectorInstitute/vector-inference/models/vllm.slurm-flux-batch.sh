#!/bin/bash
#FLUX: --job-name=blue-leopard-6857
#FLUX: -c=16
#FLUX: -t=14400
#FLUX: --urgency=16

module load cuda-12.3
nvidia-smi
source ${VENV_BASE}/bin/activate
source $(dirname ${MODEL_DIR})/find_port.sh
hostname=${SLURMD_NODENAME}
vllm_port_number=$(find_available_port $hostname 8080 65535)
echo "Server address: http://${hostname}:${vllm_port_number}/v1"
echo "http://${hostname}:${vllm_port_number}/v1" > ${VLLM_BASE_URL_FILENAME}
python3 -m vllm.entrypoints.openai.api_server \
--model ${VLLM_MODEL_WEIGHTS} \
--host "0.0.0.0" \
--port ${vllm_port_number} \
--tensor-parallel-size ${NUM_GPUS} \
--dtype ${VLLM_DATA_TYPE} \
--max-logprobs ${VLLM_MAX_LOGPROBS} 
