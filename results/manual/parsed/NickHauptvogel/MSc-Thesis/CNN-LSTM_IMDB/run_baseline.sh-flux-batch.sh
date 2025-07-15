#!/bin/bash
#FLUX: --job-name=confused-pot-0128
#FLUX: -t=1200
#FLUX: --urgency=16

folder="CNN-LSTM_IMDB/"
out_folder="results/sse"
if [ -z ${SLURM_ARRAY_TASK_ID+x} ]; then
    SLURM_ARRAY_TASK_ID=1
fi
nvidia-smi
printf "\n\n* * * Run SGD for ID = $SLURM_ARRAY_TASK_ID. * * *\n\n\n"
python -m sgd_baseline \
    --id=$(printf "%02d" $SLURM_ARRAY_TASK_ID) \
    --seed=$SLURM_ARRAY_TASK_ID \
    --out_folder=$out_folder \
    --nesterov \
    --map_optimizer \
    --epochs=50 \
    --validation_split=0.2 \
    --checkpointing \
    --checkpoint_every=5 \
    --SSE_lr
    #--checkpoint_every_epoch \
    #--initial_lr=0.001
