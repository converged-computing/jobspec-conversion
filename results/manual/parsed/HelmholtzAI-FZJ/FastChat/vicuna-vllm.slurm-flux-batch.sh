#!/bin/bash
#FLUX: --job-name=vic33vllm
#FLUX: -c=8
#FLUX: -t=360000
#FLUX: --priority=16

export BLABLADOR_DIR='/p/haicluster/llama/FastChat'
export LOGDIR='$BLABLADOR_DIR/logs'
export NCCL_P2P_DISABLE='1 # 3090s do not support p2p'

echo "I AM ON "$(hostname) " running vicuna 33 with 4 gpus"
export BLABLADOR_DIR="/p/haicluster/llama/FastChat"
export LOGDIR=$BLABLADOR_DIR/logs
export NCCL_P2P_DISABLE=1 # 3090s do not support p2p
cd $BLABLADOR_DIR
source $BLABLADOR_DIR/sc_venv_falcon/activate.sh
srun python3 $BLABLADOR_DIR/fastchat/serve/vllm_worker.py \
     --controller http://haicluster1.fz-juelich.de:21001 \
     --port 31011 --worker-address http://$(hostname):31011 \
     --num-gpus 4 \
     --host 0.0.0.0 \
     --model-path models/vicuna-33b-v1.3 \
     # --load-8bit
     # --max-gpu-memory 23Gb \
