#!/bin/bash
#SBATCH --job-name=mhp
#SBATCH --mail-user=cpaxton3@jhu.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu

export DATASET='ctp_dec'
export train_image_encoder='false'
export train_multi_encoder='false'
export learning_rate='$1'
export dropout='$2'
export optimizer='$3'
export noise_dim='$4'
export loss='$5'
export MODELDIR='$HOME/.costar/stack_$learning_rate$optimizer$dropout$noise_dim$loss'

echo "Running $@ on $SLURMD_NODENAME ..."
module load tensorflow/cuda-8.0/r1.3 
export DATASET="ctp_dec"
export train_image_encoder=false
export train_multi_encoder=false
export learning_rate=$1
export dropout=$2
export optimizer=$3
export noise_dim=$4
export loss=$5
export MODELDIR="$HOME/.costar/stack_$learning_rate$optimizer$dropout$noise_dim$loss"
$HOME/costar_plan/costar_models/scripts/ctp_model_tool \
  --features multi \
  -e 100 \
  --model predictor \
  --data_file $HOME/work/$DATASET.h5f \
  --lr $learning_rate \
  --dropout_rate $dropout \
  --model_directory $MODELDIR/ \
  --optimizer $optimizer \
  --use_noise \
  --steps_per_epoch 500 \
  --loss $loss \
  --skip_connections 1 \
  --batch_size 64 # --retrain 
  #--success_only \
