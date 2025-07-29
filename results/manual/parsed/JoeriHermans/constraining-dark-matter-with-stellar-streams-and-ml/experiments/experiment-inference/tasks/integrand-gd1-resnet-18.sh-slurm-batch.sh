#!/bin/bash
#FLUX: --job-name=STREAM_INFERENCE_INTEGRAND_GD1
#FLUX: -c=2
#FLUX: -t=604800
#FLUX: --urgency=16

model_query="$BASE/out/coverage/$EXPERIMENT_BATCH_SIZE/marginalized/$EXPERIMENT_ACTIVATION/ratio-estimator-resnet-18-$EXPERIMENT_EPOCHS-dropout-$EXPERIMENT_DROPOUT-wd-$EXPERIMENT_WEIGHT_DECAY-batchnorm-0-*/best-model.th"
out=$BASE/out/gd1/integrand-resnet-18-marginalized.npy
if [ ! -f $out -o $PROJECT_FORCE_RERUN -ne 0 ]; then
    python -u integrand.py \
           --data $DATADIR/observed-noised.npy \
           --model $model_query \
           --out $out
fi
