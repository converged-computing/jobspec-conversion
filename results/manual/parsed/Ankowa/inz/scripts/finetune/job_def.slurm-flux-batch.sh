#!/bin/bash
#FLUX: --job-name=bloated-arm-0088
#FLUX: -n=8
#FLUX: -t=72000
#FLUX: --urgency=16

gpu_id=$CUDA_VISIBLE_DEVICES
echo $gpu_id
gpu_formated="${gpu_id//,/_}"
docker_name=sd_split$gpu_formated
docker run -it --rm -d --gpus "\"device=${gpu_id}\"" -v `pwd`:/root/ --name $docker_name --ipc=host ninja0/mmdet:pytorch1.7.1-py37-cuda11.0-openmpi-mmcv1.3.3-apex-timm
docker exec $docker_name git clone https://github.com/huggingface/diffusers
docker exec $docker_name echo "repo cloned"
docker exec $docker_name bash scripts/finetune/setup.sh
docker exec $docker_name echo "everything set up correctly"
docker exec $docker_name bash scripts/finetune/script.sh
docker exec $docker_name echo "train script finished"
docker stop $docker_name
docker rm $docker_name
