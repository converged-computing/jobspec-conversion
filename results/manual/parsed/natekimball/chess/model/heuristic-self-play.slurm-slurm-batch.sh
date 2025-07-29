#!/bin/bash
#SBATCH --job-name=heuristic-self-play
#SBATCH --account=bii_dsc_community
#SBATCH --output=%u-%j.out
#SBATCH --error=%u-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --partition=bii

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
