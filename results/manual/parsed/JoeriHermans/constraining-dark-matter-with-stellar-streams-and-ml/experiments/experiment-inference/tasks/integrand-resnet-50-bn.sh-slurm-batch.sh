#!/bin/bash
#FLUX: --job-name=STREAM_INFERENCE_INTEGRAND_RESNET_50_BN
#FLUX: -c=2
#FLUX: -t=604800
#FLUX: --urgency=16

model_query="$BASE/out/coverage/$EXPERIMENT_BATCH_SIZE/marginalized/$EXPERIMENT_ACTIVATION/ratio-estimator-resnet-50-$EXPERIMENT_TASK_EPOCHS-dropout-$EXPERIMENT_DROPOUT-wd-$EXPERIMENT_WEIGHT_DECAY-batchnorm-1-*/best-model.th"
suffix=$(printf "%05d" $SLURM_ARRAY_TASK_ID)
out=$BASE/out/coverage/$EXPERIMENT_BATCH_SIZE/marginalized/$EXPERIMENT_ACTIVATION/integrand-resnet-50-bn-$suffix.npy
if [ ! -f $out -o $PROJECT_FORCE_RERUN -ne 0 ]; then
    python -u integrand.py \
           --data $DATADIR_TEST \
           --model $model_query \
           --out $out
fi
