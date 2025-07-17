#!/bin/bash
#FLUX: --job-name=bias_identification
#FLUX: -N=3
#FLUX: -n=3
#FLUX: --queue=a40
#FLUX: -t=360000
#FLUX: --urgency=16

export MASTER_ADDR='$MAIN_HOST'
export MASTER_PORT='$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1])')'
export NCCL_DEBUG='INFO'
export NCCL_IB_DISABLE='1'

MAIN_HOST=`hostname -s`
export MASTER_ADDR=$MAIN_HOST
export MASTER_PORT="$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1])')"
export NCCL_DEBUG=INFO
export NCCL_IB_DISABLE=1
if [[ "${SLURM_JOB_PARTITION}" == "t4v2" ]] || \
    [[ "${SLURM_JOB_PARTITION}" == "rtx6000" ]]; then
    echo export NCCL_SOCKET_IFNAME=bond0 on ${SLURM_JOB_PARTITION}
    export NCCL_SOCKET_IFNAME=bond0
fi
ln -sfn /checkpoint/${USER}/${SLURM_JOB_ID} checkpoints
touch checkpoints/DELAYPURGE
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --setting adv --temp 0.1 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1"
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --setting adv --explanation --temp 0.1 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1" 
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --setting adv --temp 0.5 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1"
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --setting adv --explanation --prompt_file decoding_trust_top_3.csv --temp 0.5 --run \${SLURM_PROCID} >> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1"
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --setting adv --temp 1 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1"
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --setting adv --explanation --temp 1 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1"
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --setting adv --model_name /model-weights/Mistral-7B-Instruct-v0.1/ --temp 0.1 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1"
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --setting adv --model_name /model-weights/Mistral-7B-Instruct-v0.1/ --explanation --temp 0.1 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1" 
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --setting adv --model_name /model-weights/Mistral-7B-Instruct-v0.1/ --temp 0.5 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1"
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --setting adv --model_name /model-weights/Mistral-7B-Instruct-v0.1/ --explanation --prompt_file decoding_trust_top_3.csv --temp 0.5 --run \${SLURM_PROCID} >> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1"
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --setting adv --model_name /model-weights/Mistral-7B-Instruct-v0.1/ --temp 1 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1"
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --setting adv --model_name /model-weights/Mistral-7B-Instruct-v0.1/ --explanation --temp 1 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1"
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py  --model_name /model-weights/Llama-2-7b-hf/ --temp 0.1 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1" 
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --model_name /model-weights/Llama-2-7b-hf/ --explanation --temp 0.1 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1" 
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --model_name /model-weights/Llama-2-7b-hf/ --temp 0.5 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1"
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --model_name /model-weights/Llama-2-7b-hf/ --explanation --prompt_file decoding_trust_top_3.csv --temp 0.5 --run \${SLURM_PROCID} >> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1"
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --model_name /model-weights/Llama-2-7b-hf/ --temp 1 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1"
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --model_name /model-weights/Llama-2-7b-hf/ --explanation --temp 1 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1" 
    /opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --setting adv --model_name /model-weights/Llama-2-7b-hf/ --temp 0.1 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1"
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --setting adv --model_name /model-weights/Llama-2-7b-hf/ --explanation --temp 0.1 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1" 
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --setting adv --model_name /model-weights/Llama-2-7b-hf/ --temp 0.5 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1"
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --setting adv --model_name /model-weights/Llama-2-7b-hf/ --explanation --prompt_file decoding_trust_top_3.csv --temp 0.5 --run \${SLURM_PROCID} >> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1"
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --setting adv --model_name /model-weights/Llama-2-7b-hf/ --temp 1 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1"
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --setting adv --model_name /model-weights/Llama-2-7b-hf/ --explanation --temp 1 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1"
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py  --model_name /model-weights/Mistral-7B-Instruct-v0.1/ --temp 0.1 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1" 
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --model_name /model-weights/Mistral-7B-Instruct-v0.1/ --explanation --temp 0.1 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1" 
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --model_name /model-weights/Mistral-7B-Instruct-v0.1/ --temp 0.5 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1"
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --model_name /model-weights/Mistral-7B-Instruct-v0.1/ --explanation --prompt_file decoding_trust_top_3.csv --temp 0.5 --run \${SLURM_PROCID} >> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1"
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --model_name /model-weights/Mistral-7B-Instruct-v0.1/ --temp 1 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1"
/opt/slurm/bin/srun --nodes=3 --mem=50G bash -c \
    "python3 adv_graph_decodingtrust.py --model_name /model-weights/Mistral-7B-Instruct-v0.1/ --explanation --temp 1 --prompt_file decoding_trust_top_3.csv --run \${SLURM_PROCID}>> log_for_\${SLURM_JOB_ID}_node_\${SLURM_PROCID}.log 2>&1" 
