#!/bin/bash
#FLUX: --job-name=STREAM_INFERENCE_ROC_MLP_BN
#FLUX: -c=4
#FLUX: -t=604800
#FLUX: --urgency=16

model_query="$BASE/out/coverage/$EXPERIMENT_BATCH_SIZE/marginalized/$EXPERIMENT_ACTIVATION/ratio-estimator-mlp-$EXPERIMENT_EPOCHS-dropout-$EXPERIMENT_DROPOUT-wd-$EXPERIMENT_WEIGHT_DECAY-batchnorm-1-*/best-model.th"
suffix=$(printf "%05d" $SLURM_ARRAY_TASK_ID)
out=$BASE/out/coverage/$EXPERIMENT_BATCH_SIZE/marginalized/$EXPERIMENT_ACTIVATION/roc-mlp-bn-$suffix.pickle
if [ ! -f $out -o $PROJECT_FORCE_RERUN -ne 0 ]; then
    python -u diagnose-ratio.py \
           --model $model_query \
           --experiment $SLURM_ARRAY_TASK_ID \
           --out $out
fi
