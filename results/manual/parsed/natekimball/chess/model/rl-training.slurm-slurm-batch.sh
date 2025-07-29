#!/bin/bash
#SBATCH --job-name=rl-training
#SBATCH --account=bii_dsc_community
#SBATCH --output=%u-%j.out
#SBATCH --error=%u-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100
#SBATCH --time=3-00:00:00
#SBATCH --partition=bii-gpu

export USER_SCRATCH='/scratch/$USER'
export PROJECT_DIR='$USER_SCRATCH/chess'
export MODEL_DIR='$PROJECT_DIR/model'
export CHECKPOINT_DIR='$MODEL_DIR/training_checkpoints'

date
nvidia-smi
module purge
module load cuda cudatoolkit cudnn gcc/11.2.0 rust/1.66.1
export USER_SCRATCH=/scratch/$USER
export PROJECT_DIR=$USER_SCRATCH/chess
export MODEL_DIR=$PROJECT_DIR/model
export CHECKPOINT_DIR=$MODEL_DIR/training_checkpoints
mkdir $CHECKPOINT_DIR
cd $PROJECT_DIR
cargo run --release -- --self-play --depth 2 --num-games 10
cd $MODEL_DIR
python ckpt-convert.py --model-path $MODEL_DIR/model --out-dir $MODEL_DIR/new_model
