#!/bin/bash
#FLUX: --job-name=creamy-lemur-9770
#FLUX: -n=40
#FLUX: -t=259200
#FLUX: --urgency=16

python2 crnn_main_online.py --random_sample --trainroot='../train_online_80k/' --valroot='../val_online_15k/' --cuda --adadelta --batchSize=64
