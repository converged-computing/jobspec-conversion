#!/bin/bash
#FLUX: --job-name=faux-soup-0599
#FLUX: -t=259200
#FLUX: --urgency=16

python2 crnn_main_online.py --random_sample --trainroot='../train_online_80k/' --valroot='../val_online_15k/' --cuda --adadelta --batchSize=64
