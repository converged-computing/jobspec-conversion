#!/bin/bash
#FLUX: --job-name=psycho-taco-6930
#FLUX: -t=345600
#FLUX: --urgency=16

echo "[voc12/train.rn50.all.sh] started running at $(date +'%Y-%m-%d %H:%M:%S')."
nodeset -e $SLURM_JOB_NODELIST
module load sequana/current
module load gcc/7.4_sequana python/3.9.1_sequana cudnn/8.2_cuda-11.1_sequana
cd $SCRATCH/salient-segmentation
set -o allexport
source ./config/sdumont/.env
set +o allexport
SOURCE=experiments/train_and_finetune.py
EXPERIMENT=rn101-randaug-kernel-usage
EXPERIMENT_TAGS="['voc12', 'rn101', 'momentum', 'randaug', 'kernel-usage']"
LOGS=$LOGS_DIR/classification/voc12/regularization
mkdir -p $LOGS
CUDA_VISIBLE_DEVICES=0 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/classification/datasets/voc12.yml                \
  config/augmentation/randaug.yml                         \
  config/models/rn101.yml                                 \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/classification/regularizers/kernel-usage.yml     \
  config/training/preinitialized-training.yml             \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup/rnr101-kernel-usage                   \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Job [$EXPERIMENT] stacked. Logs will be placed at $LOGS/$EXPERIMENT.log"
wait
