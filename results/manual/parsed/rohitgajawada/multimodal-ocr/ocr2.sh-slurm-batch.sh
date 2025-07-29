#!/bin/bash
#SBATCH --account=rohit.gajawada
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=8192
#SBATCH --time=3-00:00:00

python2 crnn_main_online.py --random_sample --trainroot='../train_online_80k/' --valroot='../val_online_15k/' --cuda --adadelta --batchSize=64
