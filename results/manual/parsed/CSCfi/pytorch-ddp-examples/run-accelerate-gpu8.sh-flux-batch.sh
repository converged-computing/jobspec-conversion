#!/bin/bash
#FLUX: --job-name=red-onion-8365
#FLUX: -N=2
#FLUX: -c=40
#FLUX: --queue=gputest
#FLUX: -t=900
#FLUX: --urgency=16

module purge
module load pytorch
MASTER_IP=$(ip -4 -brief addr show | grep -E 'hsn0|ib0' | grep -oP '([\d]+.[\d.]+)')
MASTER_PORT=29400
srun accelerate.sh --multi_gpu --num_processes=8 --num_machines=2 \
     --mixed_precision=no --dynamo_backend=no \
     --main_process_ip=$MASTER_IP --main_process_port=$MASTER_PORT \
     mnist_accelerate.py --epochs=100
