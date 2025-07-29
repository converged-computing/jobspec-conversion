#!/bin/bash
#SBATCH --job-name=STREAM_INFERENCE_COVERAGE_RESNET_18_BN_MARGINALIZED_BIAS
#SBATCH --output=logging/coverage_resnet_18_bn_marginalized_bias_%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=5000
#SBATCH --time=7-00:00:00

model_query="$BASE/out/coverage/$EXPERIMENT_BATCH_SIZE/marginalized/$EXPERIMENT_ACTIVATION/ratio-estimator-resnet-18-$EXPERIMENT_TASK_EPOCHS-dropout-$EXPERIMENT_DROPOUT-wd-$EXPERIMENT_WEIGHT_DECAY-batchnorm-1-*/best-model.th"
suffix=$(printf "%05d" $SLURM_ARRAY_TASK_ID)
out=$BASE/out/coverage/$EXPERIMENT_BATCH_SIZE/marginalized/$EXPERIMENT_ACTIVATION/coverage-bias-$EXPERIMENT_TASK_COVERAGE-resnet-18-bn-marginalized-$suffix.npy
if [ ! -f $out -o $PROJECT_FORCE_RERUN -ne 0 ]; then
    python -u coverage.py \
           --bias $EXPERIMENT_TASK_CR_BIAS \
           --level $EXPERIMENT_TASK_COVERAGE \
           --data $DATADIR_TEST \
           --model $model_query \
           --out $out
fi
