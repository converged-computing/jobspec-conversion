#!/bin/bash
#FLUX: --job-name=psycho-sundae-9601
#FLUX: -t=14400
#FLUX: --priority=16

export CUDA_HOME='/opt/common/cuda/cuda-11.8.0/'
export LD_LIBRARY_PATH='/opt/common/cudnn/cudnn-11.x-8.8.0.121/lib64:/opt/common/cuda/cuda-11.8.0/lib64'

eval "$(conda shell.zsh hook)"
module load CUDA/11.8.0
module load cudnn/v8.8.0
nvidia-smi
conda activate threestudio
export CUDA_HOME="/opt/common/cuda/cuda-11.8.0/"
export LD_LIBRARY_PATH="/opt/common/cudnn/cudnn-11.x-8.8.0.121/lib64:/opt/common/cuda/cuda-11.8.0/lib64"
python train.py -s /fs/nexus-scratch/hwl/prj-group-animal-synthetic/data/rabbit_static_16 --port 7860 --expname "rabbit_static_16" --configs arguments/dnerf/chicken_cam.py
python train.py -s /fs/nexus-scratch/hwl/prj-group-animal-synthetic/data/rabbit_static_4 --port 7860 --expname "rabbit_static_4" --configs arguments/dnerf/chicken_cam.py
python train.py -s /fs/nexus-scratch/hwl/prj-group-animal-synthetic/data/rabbit_dynamic_16 --port 7860 --expname "rabbit_dynamic_16" --configs arguments/dnerf/chicken_cam.py
python train.py -s /fs/nexus-scratch/hwl/prj-group-animal-synthetic/data/rabbit_dynamic_4 --port 7860 --expname "rabbit_dynamic_4" --configs arguments/dnerf/chicken_cam.py
echo "Done"
