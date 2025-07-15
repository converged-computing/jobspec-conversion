#!/bin/bash
#FLUX: --job-name=acml2
#FLUX: -t=432000
#FLUX: --priority=16

cd $HOME/midi-rnn/
module switch intel gcc
module load python/3.6.8
module load cuda/100
module load cudnn/7.4
pip install --user -r requirements.txt
python3 train_gpu.py --rnn_size 64 --num_layers 1 --window_size 20 --batch_size 32 --num_epochs 10 --dropout 0.2 --grad_clip 5 --n_jobs 1 --max_files_in_ram 25
python3 train_gpu.py --rnn_size 128 --num_layers 1 --window_size 64 --batch_size 32 --num_epochs 50 --dropout 0.2 --grad_clip 5 --n_jobs 1 --max_files_in_ram 25
python3 train_gpu.py --rnn_size 256 --num_layers 2 --window_size 256 --batch_size 32 --num_epochs 100 --dropout 0.5 --grad_clip 5 --n_jobs 1 --max_files_in_ram 25
python3 sample.py --experiment_dir experiments/01
python3 sample.py --experiment_dir experiments/02
python3 sample.py --experiment_dir experiments/03
