#!/bin/bash
#FLUX: --job-name=STREAM_INFERENCE_DIAGNOSTIC_MAP_CONVERGENCE
#FLUX: -c=4
#FLUX: -t=604800
#FLUX: --urgency=16

suffix=$(printf "%05d" $SLURM_ARRAY_TASK_ID)
data=$DATADIR/nominal/block-$suffix
out=$BASE/out/posterior/contrasts/noisy/marginalized/$EXPERIMENT_ACTIVATION
model=$out/ratio-estimator-depth-$EXPERIMENT_RESNET_DEPTH-$EXPERIMENT_EPOCHS-dropout-$EXPERIMENT_DROPOUT-wd-$EXPERIMENT_WEIGHT_DECAY-batchnorm-$EXPERIMENT_BATCHNORM-\*best-model.th
if [ ! -f $out/diagnostic-integrand.npy -o $PROJECT_FORCE_RERUN -ne 0 ]; then
    python -u diagnose-map-convergence.py \
           --data $data \
           --model $model \
           --out $out
fi
out=$BASE/out/posterior/contrasts/noisy/not-marginalized/$EXPERIMENT_ACTIVATION
model=$out/ratio-estimator-depth-$EXPERIMENT_RESNET_DEPTH-$EXPERIMENT_EPOCHS-dropout-$EXPERIMENT_DROPOUT-wd-$EXPERIMENT_WEIGHT_DECAY-batchnorm-$EXPERIMENT_BATCHNORM-\*/best-model.th
if [ ! -f $out/diagnostic-integrand.npy -o $PROJECT_FORCE_RERUN -ne 0 ]; then
    python -u diagnose-map-convergence.py \
           --data $data \
           --model $model \
           --out $out
fi
