#!/bin/bash
#FLUX: --job-name=STREAM_INFERENCE_DIAGNOSTIC_ROC_1D
#FLUX: -c=4
#FLUX: -t=604800
#FLUX: --urgency=16

suffix=$(printf "%05d" $SLURM_ARRAY_TASK_ID)
marginal_data=$DATADIR/test
out=$BASE/out/posterior/noisy/marginalized/$EXPERIMENT_ACTIVATION
model=$out/ratio-estimator-depth-$EXPERIMENT_RESNET_DEPTH-$EXPERIMENT_EPOCHS-dropout-$EXPERIMENT_DROPOUT-wd-$EXPERIMENT_WEIGHT_DECAY-batchnorm-$EXPERIMENT_BATCHNORM-\*/best-model.th
if [ ! -f $out/diagnostic-roc.pickle -o $PROJECT_FORCE_RERUN -ne 0 ]; then
    python -u diagnose-ratio.py \
           --likelihood $DATADIR/nominal/block-$suffix \
           --marginal $marginal_data \
           --model $model \
           --out $out/diagnostic-roc-$suffic.pickle
fi
out=$BASE/out/posterior/clean/marginalized/$EXPERIMENT_ACTIVATION
model=$out/ratio-estimator-depth-$EXPERIMENT_RESNET_DEPTH-$EXPERIMENT_EPOCHS-dropout-$EXPERIMENT_DROPOUT-wd-$EXPERIMENT_WEIGHT_DECAY-batchnorm-$EXPERIMENT_BATCHNORM-\*/best-model.th
if [ ! -f $out/diagnostic-roc.pickle -o $PROJECT_FORCE_RERUN -ne 0 ]; then
    python -u diagnose-ratio.py \
           --likelihood $DATADIR/nominal/block-$suffix \
           --marginal $marginal_data \
           --model $model \
           --out $out/diagnostic-roc-$suffic.pickle
fi
