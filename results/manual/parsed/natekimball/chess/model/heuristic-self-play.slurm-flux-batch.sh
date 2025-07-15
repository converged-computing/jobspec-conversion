#!/bin/bash
#FLUX: --job-name=heuristic-self-play
#FLUX: --queue=bii
#FLUX: -t=86400
#FLUX: --priority=16

export CHESS_DIR='/scratch/tma5gv/chess'
export MODEL_DIR='$CHESS_DIR/model'
export CHECKPOINT_DIR='$MODEL_DIR/training_checkpoints'

date
nvidia-smi
module purge
module load gcc/11.2.0 rust/1.66.1
export CHESS_DIR=/scratch/tma5gv/chess
export MODEL_DIR=$CHESS_DIR/model
export CHECKPOINT_DIR=$MODEL_DIR/training_checkpoints
cd $CHESS_DIR
cargo run --release -- --self-play --heuristic --depth 5
