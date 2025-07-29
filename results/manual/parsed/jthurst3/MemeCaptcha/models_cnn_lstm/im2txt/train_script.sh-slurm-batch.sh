#!/bin/bash
#SBATCH --job-name=first_train
#SBATCH --output=slurm_logs/first_train.out
#SBATCH --error=slurm_logs/first_train.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10GB
#SBATCH --time=10:00:00

module load caffe
IM2TXT_DIR=/public/jthurst3/MemeCaptcha
MEME_DIR="${IM2TXT_DIR}/tensorflow_input_data"
INCEPTION_CHECKPOINT="${IM2TXT_DIR}/checkpoints/inception_v3.ckpt"
MODEL_DIR="${IM2TXT_DIR}/models/cnn_lstm_run1"
module load bazel
bazel build -c opt im2txt/...
echo $IM2TXT_DIR $MEME_DIR $INCEPTION_CHECKPOINT $MODEL_DIR
bazel-bin/im2txt/train \
  --input_file_pattern="${MEME_DIR}/train-?????-of-00256" \
  --inception_checkpoint_file="${INCEPTION_CHECKPOINT}" \
  --train_dir="${MODEL_DIR}/train" \
  --train_inception=false \
  --number_of_steps=1000000
