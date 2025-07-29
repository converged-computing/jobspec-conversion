#!/bin/bash
#FLUX: --job-name=STREAM_INFERENCE_COVERAGE_FREQUENTIST_MLP_MARGINALIZED
#FLUX: -c=2
#FLUX: -t=604800
#FLUX: --urgency=16

model_query="$BASE/out/coverage/$EXPERIMENT_BATCH_SIZE/marginalized/$EXPERIMENT_ACTIVATION/ratio-estimator-mlp-$EXPERIMENT_TASK_EPOCHS-dropout-$EXPERIMENT_DROPOUT-wd-$EXPERIMENT_WEIGHT_DECAY-batchnorm-0-*/best-model.th"
suffix=$(printf "%05d" $SLURM_ARRAY_TASK_ID)
out=$BASE/out/coverage/$EXPERIMENT_BATCH_SIZE/marginalized/$EXPERIMENT_ACTIVATION/coverage-frequentist-$EXPERIMENT_TASK_COVERAGE-mlp-marginalized-$suffix.npy
if [ ! -f $out -o $PROJECT_FORCE_RERUN -ne 0 ]; then
    python -u coverage.py \
           --data $DATADIR_TEST \
           --frequentist \
           --level $EXPERIMENT_TASK_COVERAGE \
           --model $model_query \
           --out $out
fi
