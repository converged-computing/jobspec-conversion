#!/bin/bash
#SBATCH --job-name=Train_RIM_analytic_Gridsearch
#SBATCH --account=rrg-lplevass
#SBATCH --output=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=1-00:00:00
#SBATCH --array=1-100

source $HOME/environments/carrim/bin/activate
python $ARIM/pretrain_cnn_gridsearch.py\
  --n_models=100\
  --strategy=uniform\
  --cnn_architecture custom perreault_levasseur2016 resnet50 resnet101 inceptionV3\
  --cnn_levels 3 4\
  --cnn_layer_per_level 1 2\
  --cnn_input_kernel_size 7 11\
  --cnn_filters 16 32\
  --cnn_activation relu tanh swish\
  --batch_size 32\
  --total_items 20000\
  --epochs 1000\
  --optimizer adamax\
  --initial_learning_rate 1e-4 1e-5 1e-6\
  --decay_rate 1 0.9 0.8\
  --decay_steps 10000\
  --max_time 23.5\
  --checkpoints=10\
  --max_to_keep=1\
  --model_dir=$ARIM/models/\
  --logdir=$ARIM/logsA/\
  --logname_prefixe=CNN_g1\
  --seed 42
