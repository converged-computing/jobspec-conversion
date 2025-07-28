#!/bin/bash
#FLUX: --job-name=zly
#FLUX: --queue=gpulab02
#FLUX: --urgency=16

nvidia-smi
accelerate launch --config_file acce_config_1GPU.yaml --main_process_port 29501 train_vanilla_bert.py
accelerate launch --config_file acce_config_1GPU.yaml --main_process_port 29501 train_cos_bert.py
accelerate launch --config_file acce_config_1GPU.yaml --main_process_port 29501 train_directmul_bert.py
