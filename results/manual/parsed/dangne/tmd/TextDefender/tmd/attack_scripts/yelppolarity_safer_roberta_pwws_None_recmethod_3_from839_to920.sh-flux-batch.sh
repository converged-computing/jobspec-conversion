#!/bin/bash
#FLUX: --job-name=yelppolarity_safer_roberta_pwws_None_recmethod_3_from839_to920
#FLUX: -c=16
#FLUX: --queue=applied
#FLUX: --urgency=16

srun --container-image=/lustre/scratch/client/vinai/users/dangnm12/setup/docker_images/dc-miniconda3-py:38-4.10.3-cuda11.4.2-cudnn8-ubuntu20.04.sqsh \
     --container-mounts=/lustre/scratch/client/vinai/users/dangnm12/:/root/ \
     --container-workdir=/root/ \
     /bin/bash -c \
     "
     export HTTP_PROXY=http://proxytc.vingroup.net:9090/
     export HTTPS_PROXY=http://proxytc.vingroup.net:9090/
     export http_proxy=http://proxytc.vingroup.net:9090/
     export https_proxy=http://proxytc.vingroup.net:9090/
     export HF_DATASETS_CACHE=/root/cache/huggingface/datasets
     export TRANSFORMERS_CACHE=/root/cache/huggingface/transformers
     export TFHUB_CACHE_DIR=/root/cache/tfhub_modules
     export TF_FORCE_GPU_ALLOW_GROWTH=true 
     export TRANSFORMERS_OFFLINE=0
     export HF_DATASETS_OFFLINE=0
     export TOKENIZERS_PARALLELISM=false
     source /opt/conda/bin/activate
     cd /root
     conda activate /root/miniconda3/envs/textdef
     cd /root/TextDefender
     python main.py --mode=attack --model_type=roberta --model_name_or_path=/root/manifold_defense/models/roberta-base-yelppolarity --dataset_name=yelppolarity --dataset_path=/root/TextDefender/dataset/yelppolarity --training_type=safer --max_seq_len=256 --do_lower_case=True --attack_method=pwws --method=3 --start_index=839 --end_index=920
     "
