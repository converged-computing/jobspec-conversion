#!/bin/bash
#FLUX: --job-name=conspicuous-itch-9853
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/opt/cuda/9.0/lib64:/opt/cuda/9.0/cudnn/7.0/lib64'

ID_TO_NAME="
A
B
C
D
E
F
G
H
"
NAME=$(echo "$ID_TO_NAME" | head -n $(expr 2 + $SLURM_ARRAY_TASK_ID) | tail -n 1)
SEED=$1
if [ -z "$SEED" ]; then
    echo "Seed argument missing"
    exit 1
fi
echo "################################"
echo "# Topology train ${NAME}_${SEED}"
echo "################################"
echo
export LD_LIBRARY_PATH=/opt/cuda/9.0/lib64:/opt/cuda/9.0/cudnn/7.0/lib64
.venv/bin/python3 experiment_symbols.py train \
    --model experiment_${NAME}_${SEED} \
    --symbols datasets/experiments/${NAME}_${SEED} \
    --seed_offset $SEED
echo
echo "########"
echo "# DONE #"
echo "########"
