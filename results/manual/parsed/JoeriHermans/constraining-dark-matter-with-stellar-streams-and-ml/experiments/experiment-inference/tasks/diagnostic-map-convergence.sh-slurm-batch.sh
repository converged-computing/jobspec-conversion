#!/bin/bash
#SBATCH --job-name=STREAM_INFERENCE_DIAGNOSTIC_MAP_CONVERGENCE
#SBATCH --output=logging/diagnostic_diagnostic_map_convergence_%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=4000
#SBATCH --time=7-00:00:00

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
