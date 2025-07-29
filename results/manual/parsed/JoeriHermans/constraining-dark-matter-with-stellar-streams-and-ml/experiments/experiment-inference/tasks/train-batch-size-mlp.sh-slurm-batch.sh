#!/bin/bash
#FLUX: --job-name=STREAM_INFERENCE_TRAIN_BATCH_SIZE_MLP
#FLUX: -c=4
#FLUX: -t=604800
#FLUX: --urgency=16

suffix=$(printf "%05d" $SLURM_ARRAY_TASK_ID)
out=$BASE/out/batch-size/$EXPERIMENT_TASK_BATCH_SIZE/marginalized/$EXPERIMENT_ACTIVATION/ratio-estimator-mlp-$EXPERIMENT_TASK_EPOCHS-dropout-$EXPERIMENT_DROPOUT-wd-$EXPERIMENT_WEIGHT_DECAY-batchnorm-$EXPERIMENT_TASK_BATCHNORM-$suffix
mkdir -p $out
if [ ! -f $out/model.th -o $PROJECT_FORCE_RERUN -ne 0 ]; then
    python -u train.py \
           --activation $EXPERIMENT_ACTIVATION \
           --batch-size $EXPERIMENT_TASK_BATCH_SIZE \
           --batchnorm $EXPERIMENT_TASK_BATCHNORM \
           --beta $EXPERIMENT_CONSERVATIVE \
           --cut \
           --data-test-masses $DATADIR_TEST/masses.npy \
           --data-test-outputs $DATADIR_TEST/density-contrasts-cut-noised.npy \
           --data-train-masses $DATADIR_TRAIN/masses-r.npy \
           --data-train-outputs $DATADIR_TRAIN/density-contrasts-cut-noised.npy \
           --dropout $EXPERIMENT_DROPOUT \
           --epochs $EXPERIMENT_TASK_EPOCHS \
           --lr $EXPERIMENT_LEARNING_RATE \
           --mlp \
           --out $out \
           --weight-decay $EXPERIMENT_WEIGHT_DECAY \
           --workers $EXPERIMENT_WORKERS
fi
