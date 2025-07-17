#!/bin/bash
#FLUX: --job-name=stanky-house-5333
#FLUX: -n=4
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu
#FLUX: -t=10800
#FLUX: --urgency=16

echo "===================================="
echo "ARGS       = $@"
echo "===================================="
echo Running on host $USER@$HOSTNAME
echo Node: $(hostname)
echo Start: $(date +%F-%R:%S)
echo -e Working dir: $(pwd)
echo Dynamic shared libraries: $LD_LIBRARY_PATH
source credentials.txt
echo "====== starting experiment ========="
srun --exclusive -n 1 -o job/%J-mistral7b-instructv1.out -e job/%J-mistral7b-instructv1.err python -m vllm.entrypoints.api_server --model mistralai/Mistral-7B-Instruct-v0.1 --port 8004 --tensor-parallel-size 1 --trust-remote-code --download-dir "/project/scratch/p200149/vllm" $@ &
srun --exclusive -n 1 -o job/%J-mistral7b-instructv2.out -e job/%J-mistral7b-instructv2.err python -m vllm.entrypoints.api_server --model mistralai/Mistral-7B-Instruct-v0.2 --port 8005 --tensor-parallel-size 1 --trust-remote-code --download-dir "/project/scratch/p200149/vllm" $@ &
srun --exclusive -n 1 -o job/%J-llama13b-chat.out -e job/%J-llama13b-chat.err python -m vllm.entrypoints.api_server --model meta-llama/Llama-2-13b-chat-hf --port 8010 --tensor-parallel-size 1 --trust-remote-code --download-dir "/project/scratch/p200149/vllm" $@ &
srun --exclusive -n 1 -o job/%J-codellama13b-instruct.out -e job/%J-codellama13b-instruct.err python -m vllm.entrypoints.api_server --model codellama/CodeLlama-13b-Instruct-hf --port 8013 --tensor-parallel-size 1 --trust-remote-code --download-dir "/project/scratch/p200149/vllm" $@ &
wait
