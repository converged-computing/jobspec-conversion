#!/bin/bash
#FLUX: --job-name=Train_RIM_analytic_Gridsearch
#FLUX: -c=3
#FLUX: -t=86400
#FLUX: --urgency=16

source $HOME/environments/carrim/bin/activate
python $ARIM/rim_gridsearch.py\
  --n_models=100\
  --strategy=uniform\
  --steps 4 8 12\
  --adam 1\
  --units 16 32 64\
  --cnn_architecture custom perreault_levasseur2016 resnet50 resnet101 inceptionV3\
  --cnn_levels 3 4\
  --cnn_layer_per_level 1 2\
  --cnn_input_kernel_size 7 11\
  --cnn_filters 16 32\
  --cnn_activation relu tanh swish\
  --activation tanh elu leaky_relu\
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
  --logname_prefixe=RIMA_g1\
  --seed 42
