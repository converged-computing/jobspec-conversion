#!/bin/bash
#FLUX: --job-name=milky-egg-7609
#FLUX: --queue=GPU-shared
#FLUX: -t=18000
#FLUX: --urgency=16

module load cuda/8.0 tensorflow/0.12.1
source ${TENSORFLOW_ENV}/bin/activate
cd /pylon5/sc87lkp/richardz/src/ball_net
python ./fully_connected_feed.py \
       --network_pattern outer_layer_1_hidden \
       --batch_size 100 \
       --train_dir /pylon2/pscstaff/welling/fish_cube_links \
       --log_dir /pylon5/sc87lkp/richardz/tf/logs/layer_net \
       --num_epochs 0 \
       --read_threads 3 \
       --shuffle_size 100 \
       --n_training_examples 9987 \
       --starting_snapshot /pylon5/sc87lkp/richardz/tf/logs/layer_net-2999
