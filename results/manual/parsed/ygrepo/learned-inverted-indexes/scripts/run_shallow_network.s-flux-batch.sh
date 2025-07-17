#!/bin/bash
#FLUX: --job-name=yg390
#FLUX: -t=36000
#FLUX: --urgency=16

module purge
module load python3/intel/3.6.3
source ~/env-gpu/py3.6.3/bin/activate
EPOCHS=10000
LOG_INTERVAL=1000
BATCH_SIZE=32
POSTING_LIST_SIZE=4096
LR=0.01
LOSS_STOP_THRESHOLD=1e-3
LOSS_SCRAP=10000000
python3 src/shallow_network_train.py --epochs $EPOCHS --log-interval $LOG_INTERVAL --batch_size $BATCH_SIZE --posting_list_size $POSTING_LIST_SIZE --lr $LR --loss_stop_threshold $LOSS_STOP_THRESHOLD --loss_scrap $LOSS_SCRAP
deactivate
module purge
