#!/bin/bash
#FLUX: --job-name=persnickety-fudge-0421
#FLUX: -t=345600
#FLUX: --priority=16

echo "[cifar/train.rn50.all.sh] started running at $(date +'%Y-%m-%d %H:%M:%S')."
nodeset -e $SLURM_JOB_NODELIST
module load sequana/current
module load gcc/7.4_sequana python/3.9.1_sequana cudnn/8.2_cuda-11.1_sequana
cd $SCRATCH/salient-segmentation
set -o allexport
source ./config/sdumont/.env
set +o allexport
SOURCE=experiments/train_and_finetune.py
LOGS=$LOGS_DIR/classification/cifar10/augmentation
mkdir -p $LOGS
EXPERIMENT=rn50-noaug
EXPERIMENT_TAGS="['cifar10', 'rn50', 'momentum']"
CUDA_VISIBLE_DEVICES=0 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/training/preinitialized-training.yml             \
  config/classification/datasets/cifar10.yml              \
  config/augmentation/none.yml                            \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup                           \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Stacked [$EXPERIMENT] job"
EXPERIMENT=rn50-simpleaug
EXPERIMENT_TAGS="['cifar10', 'rn50', 'momentum', 'simpleaug']"
CUDA_VISIBLE_DEVICES=1 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/training/preinitialized-training.yml             \
  config/classification/datasets/cifar10.yml              \
  config/augmentation/simple.yml                          \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup                           \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Stacked [$EXPERIMENT] job"
EXPERIMENT=rn50-randaug
EXPERIMENT_TAGS="['cifar10', 'rn50', 'momentum', 'randaug']"
CUDA_VISIBLE_DEVICES=2 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/training/preinitialized-training.yml             \
  config/classification/datasets/cifar10.yml              \
  config/augmentation/randaug.yml                         \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup                           \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Stacked [$EXPERIMENT] job"
EXPERIMENT=rn50-randaug-dropout
EXPERIMENT_TAGS="['cifar10', 'rn50', 'momentum', 'randaug', 'dropout']"
CUDA_VISIBLE_DEVICES=1 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/training/preinitialized-training.yml             \
  config/models/rn50.yml                                  \
  config/classification/datasets/cifar10.yml              \
  config/augmentation/randaug.yml                         \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/classification/regularizers/dropout.yml          \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup                           \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Stacked [$EXPERIMENT] job"
EXPERIMENT=rn50-randaug-l1l2
EXPERIMENT_TAGS="['cifar10', 'rn50', 'momentum', 'randaug', 'l1l2']"
CUDA_VISIBLE_DEVICES=2 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/training/preinitialized-training.yml             \
  config/models/rn50.yml                                  \
  config/classification/datasets/cifar10.yml              \
  config/augmentation/randaug.yml                         \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/classification/regularizers/l1l2.yml             \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup                           \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Stacked [$EXPERIMENT] job"
EXPERIMENT=rn50-randaug-ortho
EXPERIMENT_TAGS="['cifar10', 'rn50', 'momentum', 'randaug', 'ortho']"
CUDA_VISIBLE_DEVICES=3 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/training/preinitialized-training.yml             \
  config/models/rn50.yml                                  \
  config/classification/datasets/cifar10.yml              \
  config/augmentation/randaug.yml                         \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/classification/regularizers/orthogonal.yml       \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup                           \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Stacked [$EXPERIMENT] job"
EXPERIMENT=rn50-randaug-kernel-usage
EXPERIMENT_TAGS="['cifar10', 'rn50', 'momentum', 'randaug', 'kernel-usage']"
CUDA_VISIBLE_DEVICES=3 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/training/preinitialized-training.yml             \
  config/models/rn50.yml                                  \
  config/classification/datasets/cifar10.yml              \
  config/augmentation/randaug.yml                         \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/classification/regularizers/kernel-usage.yml     \
  model.head.config.alpha=10                                          \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup                           \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Stacked [$EXPERIMENT] job"
wait
