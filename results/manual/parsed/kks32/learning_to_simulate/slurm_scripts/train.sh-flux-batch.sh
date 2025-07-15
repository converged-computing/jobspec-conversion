#!/bin/bash
#FLUX: --job-name=milky-buttface-8881
#FLUX: --priority=16

set -e
cd ..
source start_venv.sh
cd ..
data="Sand"
DATA_PATH="${WORK}/gns_tensorflow/${data}/dataset"
MODEL_PATH="${WORK}/gns_tensorflow/${data}/models"
python3 -m learning_to_simulate.train \
--data_path=${DATA_PATH} \
--model_path=${MODEL_PATH} \
--num_steps="1000000"
