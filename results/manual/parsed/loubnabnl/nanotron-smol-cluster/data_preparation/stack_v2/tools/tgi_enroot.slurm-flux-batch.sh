#!/bin/bash
#FLUX: --job-name=tgi-swarm
#FLUX: -c=12
#FLUX: --queue=hopper-prod
#FLUX: --urgency=16

export volume='/scratch'
export model='mistralai/Mistral-7B-Instruct-v0.1'
export PORT='$(unused_port)'

export volume=/scratch
export model=mistralai/Mistral-7B-Instruct-v0.1
function unused_port() {
    N=${1:-1}
    comm -23 \
        <(seq "1025" "65535" | sort) \
        <(ss -Htan |
            awk '{print $4}' |
            cut -d':' -f2 |
            sort -u) |
        shuf |
        head -n "$N"
}
export PORT=$(unused_port)
if [ -z "$HUGGING_FACE_HUB_TOKEN" ]; then
  echo "You should provide a Hugging Face token in HUGGING_FACE_HUB_TOKEN."
  exit 1
fi
echo "Starting TGI container port $PORT"
srun --container-image='/fsx/loubna/docker_images/huggingface+text-generation-inference.sqsh' \
     --container-env=HUGGING_FACE_HUB_TOKEN,PORT \
     --container-mounts="/scratch:/data" \
     --no-container-mount-home \
     --qos normal \
     /usr/local/bin/text-generation-launcher --model-id $model \
     --max-concurrent-requests 530 \
     --max-total-tokens 8192 \
     --max-input-length 7168 \
     --max-batch-prefill-tokens 7168
echo "End of job"
