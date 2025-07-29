#!/bin/bash
#SBATCH --job-name=STREAM_INFERENCE_COVERAGE_FREQUENTIST_MLP_NOT_MARGINALIZED
#SBATCH --output=logging/coverage_frequentist_mlp_bn_not_marginalized_%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=5000
#SBATCH --time=7-00:00:00

model_query="$BASE/out/coverage/$EXPERIMENT_BATCH_SIZE/marginalized/$EXPERIMENT_ACTIVATION/ratio-estimator-mlp-$EXPERIMENT_TASK_EPOCHS-dropout-$EXPERIMENT_DROPOUT-wd-$EXPERIMENT_WEIGHT_DECAY-batchnorm-1-*/best-model.th"
suffix=$(printf "%05d" $SLURM_ARRAY_TASK_ID)
out=$BASE/out/coverage/$EXPERIMENT_BATCH_SIZE/not-marginalized/$EXPERIMENT_ACTIVATION/coverage-frequentist-$EXPERIMENT_TASK_COVERAGE-mlp-bn-not-marginalized-$suffix.npy
if [ ! -f $out -o $PROJECT_FORCE_RERUN -ne 0 ]; then
    python -u coverage.py \
           --data $DATADIR_TEST \
           --frequentist \
           --level $EXPERIMENT_TASK_COVERAGE \
           --model $model_query \
           --out $out
fi
