#!/bin/bash
#FLUX: --job-name=rainbow-snack-0993
#FLUX: -t=345600
#FLUX: --urgency=16

echo "[cifar100/train.rn50.all.sh] started running at $(date +'%Y-%m-%d %H:%M:%S')."
nodeset -e $SLURM_JOB_NODELIST
module load sequana/current
module load gcc/7.4_sequana python/3.9.1_sequana cudnn/8.2_cuda-11.1_sequana
cd $SCRATCH/salient-segmentation
set -o allexport
source ./config/sdumont/.env
set +o allexport
SOURCE=experiments/train_and_finetune.py
EXPERIMENT=noaug
EXPERIMENT_TAGS="['cifar100', 'rn50', 'momentum', 'noaug']"
LOGS=$LOGS_DIR/classification/cifar100/augmentation
mkdir -p $LOGS
CUDA_VISIBLE_DEVICES=1 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/classification/datasets/cifar100.yml             \
  config/augmentation/none.yml                            \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/training/preinitialized-training.yml             \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup/noaug                                 \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Job [$EXPERIMENT] stacked. Logs will be placed at $LOGS/$EXPERIMENT.log"
EXPERIMENT=finetune-noaug
EXPERIMENT_TAGS="['cifar100', 'rn50', 'finetune', 'momentum', 'noaug']"
LOGS=$LOGS_DIR/classification/cifar100/augmentation-finetune
mkdir -p $LOGS
CUDA_VISIBLE_DEVICES=1 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/classification/datasets/cifar100.yml             \
  config/augmentation/none.yml                            \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/training/train-head-and-finetune.yml             \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup/noaug                                 \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Job [$EXPERIMENT] stacked. Logs will be placed at $LOGS/$EXPERIMENT.log"
EXPERIMENT=simpleaug
EXPERIMENT_TAGS="['cifar100', 'rn50', 'momentum', 'simpleaug']"
LOGS=$LOGS_DIR/classification/cifar100/augmentation
mkdir -p $LOGS
CUDA_VISIBLE_DEVICES=1 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/classification/datasets/cifar100.yml             \
  config/augmentation/simple.yml                          \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/training/preinitialized-training.yml             \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup/simpleaug                             \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Job [$EXPERIMENT] stacked. Logs will be placed at $LOGS/$EXPERIMENT.log"
EXPERIMENT=finetune-simpleaug
EXPERIMENT_TAGS="['cifar100', 'rn50', 'finetune', 'momentum', 'simpleaug']"
LOGS=$LOGS_DIR/classification/cifar100/augmentation-finetune
mkdir -p $LOGS
CUDA_VISIBLE_DEVICES=1 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/classification/datasets/cifar100.yml             \
  config/augmentation/simple.yml                          \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/training/train-head-and-finetune.yml             \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup/simpleaug                             \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Job [$EXPERIMENT] stacked. Logs will be placed at $LOGS/$EXPERIMENT.log"
EXPERIMENT=randaug
EXPERIMENT_TAGS="['cifar100', 'rn50', 'momentum', 'randaug']"
LOGS=$LOGS_DIR/classification/cifar100/augmentation
mkdir -p $LOGS
CUDA_VISIBLE_DEVICES=2 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/classification/datasets/cifar100.yml             \
  config/augmentation/randaug.yml                         \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/training/preinitialized-training.yml             \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup/randaug                               \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Job [$EXPERIMENT] stacked. Logs will be placed at $LOGS/$EXPERIMENT.log"
EXPERIMENT=finetune-randaug
EXPERIMENT_TAGS="['cifar100', 'rn50', 'finetune', 'momentum', 'randaug']"
LOGS=$LOGS_DIR/classification/cifar100/augmentation-finetune
mkdir -p $LOGS
CUDA_VISIBLE_DEVICES=2 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/classification/datasets/cifar100.yml             \
  config/augmentation/randaug.yml                         \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/training/train-head-and-finetune.yml             \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup/randaug                               \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Job [$EXPERIMENT] stacked. Logs will be placed at $LOGS/$EXPERIMENT.log"
EXPERIMENT=randaug-dropout
EXPERIMENT_TAGS="['cifar100', 'rn50', 'momentum', 'randaug', 'dropout']"
LOGS=$LOGS_DIR/classification/cifar100/regularization
mkdir -p $LOGS
CUDA_VISIBLE_DEVICES=2 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/classification/datasets/cifar100.yml             \
  config/augmentation/randaug.yml                         \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/classification/regularizers/dropout.yml          \
  config/training/preinitialized-training.yml             \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup/dropout                               \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Job [$EXPERIMENT] stacked. Logs will be placed at $LOGS/$EXPERIMENT.log"
EXPERIMENT=randaug-dropout
EXPERIMENT_TAGS="['cifar100', 'rn50', 'finetune', 'momentum', 'randaug', 'dropout']"
LOGS=$LOGS_DIR/classification/cifar100/regularization-finetune
mkdir -p $LOGS
CUDA_VISIBLE_DEVICES=2 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/classification/datasets/cifar100.yml             \
  config/augmentation/randaug.yml                         \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/classification/regularizers/dropout.yml          \
  config/training/train-head-and-finetune.yml             \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup/dropout                               \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Job [$EXPERIMENT] stacked. Logs will be placed at $LOGS/$EXPERIMENT.log"
EXPERIMENT=randaug-l1l2
EXPERIMENT_TAGS="['cifar100', 'rn50', 'momentum', 'randaug', 'l1l2']"
LOGS=$LOGS_DIR/classification/cifar100/regularization
mkdir -p $LOGS
CUDA_VISIBLE_DEVICES=3 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/classification/datasets/cifar100.yml             \
  config/augmentation/randaug.yml                         \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/classification/regularizers/l1l2.yml             \
  config/training/preinitialized-training.yml             \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup/l1l2                                  \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Job [$EXPERIMENT] stacked. Logs will be placed at $LOGS/$EXPERIMENT.log"
EXPERIMENT=randaug-l1l2
EXPERIMENT_TAGS="['cifar100', 'rn50', 'finetune', 'momentum', 'randaug', 'l1l2']"
LOGS=$LOGS_DIR/classification/cifar100/regularization-finetune
mkdir -p $LOGS
CUDA_VISIBLE_DEVICES=3 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/classification/datasets/cifar100.yml             \
  config/augmentation/randaug.yml                         \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/classification/regularizers/l1l2.yml             \
  config/training/train-head-and-finetune.yml             \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup/l1l2                                  \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Job [$EXPERIMENT] stacked. Logs will be placed at $LOGS/$EXPERIMENT.log"
EXPERIMENT=randaug-ortho
EXPERIMENT_TAGS="['cifar100', 'rn50', 'momentum', 'randaug', 'ortho']"
LOGS=$LOGS_DIR/classification/cifar100/regularization
mkdir -p $LOGS
CUDA_VISIBLE_DEVICES=3 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/classification/datasets/cifar100.yml             \
  config/augmentation/randaug.yml                         \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/classification/regularizers/orthogonal.yml       \
  config/training/preinitialized-training.yml             \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup/ortho                                 \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Job [$EXPERIMENT] stacked. Logs will be placed at $LOGS/$EXPERIMENT.log"
EXPERIMENT=randaug-ortho
EXPERIMENT_TAGS="['cifar100', 'rn50', 'finetune', 'momentum', 'randaug', 'ortho']"
LOGS=$LOGS_DIR/classification/cifar100/regularization-finetune
mkdir -p $LOGS
CUDA_VISIBLE_DEVICES=3 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/classification/datasets/cifar100.yml             \
  config/augmentation/randaug.yml                         \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/classification/regularizers/orthogonal.yml       \
  config/training/train-head-and-finetune.yml             \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup/ortho                                 \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Job [$EXPERIMENT] stacked. Logs will be placed at $LOGS/$EXPERIMENT.log"
EXPERIMENT=randaug-kernel-usage
EXPERIMENT_TAGS="['cifar100', 'rn50', 'momentum', 'randaug', 'kernel-usage']"
LOGS=$LOGS_DIR/classification/cifar100/regularization
mkdir -p $LOGS
CUDA_VISIBLE_DEVICES=0 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/classification/datasets/cifar100.yml             \
  config/augmentation/randaug.yml                         \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/classification/regularizers/kernel-usage.yml     \
  config/training/preinitialized-training.yml             \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup/kernel-usage                          \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Job [$EXPERIMENT] stacked. Logs will be placed at $LOGS/$EXPERIMENT.log"
EXPERIMENT=randaug-kernel-usage
EXPERIMENT_TAGS="['cifar100', 'rn50', 'finetune', 'momentum', 'randaug', 'kernel-usage']"
LOGS=$LOGS_DIR/classification/cifar100/regularization-finetune
mkdir -p $LOGS
CUDA_VISIBLE_DEVICES=0 python3.9 $SOURCE with             \
  config/classification/train_and_finetune.yml                   \
  config/classification/datasets/cifar100.yml             \
  config/augmentation/randaug.yml                         \
  config/classification/optimizers/momentum_nesterov.yml  \
  config/classification/regularizers/kernel-usage.yml     \
  config/training/train-head-and-finetune.yml             \
  config/environment/precision-mixed-float16.yml          \
  config/environment/sdumont.yml                          \
  config/logging/wandb.train.yml                          \
  setup.paths.ckpt=$LOGS/backup/kernel-usage                          \
  setup.paths.wandb_dir=$LOGS                             \
  setup.wandb.name=$EXPERIMENT                            \
  setup.wandb.tags="$EXPERIMENT_TAGS"                     \
  -F $LOGS                                                \
  &> $LOGS/$EXPERIMENT.log                                &
echo "Job [$EXPERIMENT] stacked. Logs will be placed at $LOGS/$EXPERIMENT.log"
wait
