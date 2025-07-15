#!/bin/bash
#FLUX: --job-name=conspicuous-parsnip-6398
#FLUX: --queue=v100_full_node
#FLUX: --priority=16

MASTER=`/bin/hostname -s`
MPORT=$(shuf -i 6000-9999 -n 1)
echo "Master: $MASTER"
echo "Port: $MPORT"
jobdir="$(dirname "$(dirname "$(pwd)")")";
CONFIG=$1
DATASET=$2
WEIGHT=$3
WEIGHT_PATH=${WEIGHT}
SEED=${4:-42}
cd $jobdir;
python eval_finetune_open_set.py \
            --checkpoint_path ${CKPTDIR} \
            --dist-url tcp://${MASTER}:${MPORT} \
            --dist-backend 'nccl' \
            --multiprocessing-distributed \
            --world-size 1 --rank 0 \
            --quiet --sub_dir 'open_set' \
            --db ${DATASET} \
            --config-file ${CONFIG} \
            --weight_path ${WEIGHT_PATH} \
            --seed $SEED
