#!/bin/bash
#FLUX: --job-name=nerdy-plant-4437
#FLUX: --queue=bii-gpu
#FLUX: -t=129600
#FLUX: --priority=16

module load anaconda
conda activate OSMI
cd /project/bii_dsc_community/tma5gv/osmi/osmi-bench/model
time python train.py $MODE
cd /project/bii_dsc_community/tma5gv/osmi/osmi-bench/benchmark
pip install --user  -r mlcommons-osmi/../../../requirements-rivanna.txt
singularity run --nv --home `pwd` ../serving_latest-gpu.sif tensorflow_model_server --port=8500 --rest_api_port=0 --model_config_file=models.conf >& log &
sleep 12 # thats not cool
nvidia-smi
MODE=small_lstm
PARAMETER=-b 32 -n 48
time python tfs_grpc_client.py -m $MODE $PARAMETER localhost:8500
