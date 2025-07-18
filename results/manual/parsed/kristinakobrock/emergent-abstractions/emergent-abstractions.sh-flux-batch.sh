#!/bin/bash
#FLUX: --job-name=mu_4_4_generic
#FLUX: -c=30
#FLUX: --queue=gpu
#FLUX: -t=72000
#FLUX: --urgency=16

source $HOME/.bashrc
spack load miniconda3@4.10.3
conda activate egg 
srun python $HOME/emergent-abstractions/train.py --batch_size 32 --n_epochs 300 --dimensions 4 4 4 4 --learning_rate 0.001 --game_size 10 --hidden_size 128 --temp_update 0.99 --temperature 2 --save True --num_of_runs 5 --path "$HOME/emergent-abstractions/" --mu_and_goodman True --speaker_hidden_size 128 --listener_hidden_size 128 --zero_shot True --zero_shot_test 'generic'
srun sleep 10
