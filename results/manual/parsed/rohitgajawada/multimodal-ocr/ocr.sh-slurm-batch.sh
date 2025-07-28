#!/bin/bash
#FLUX: --job-name=strawberry-squidward-4570
#FLUX: -n=40
#FLUX: -t=259200
#FLUX: --urgency=16

python2 crnn_main.py --random_sample --trainroot='../train_80k/' --valroot='../val_15k/' --cuda --adadelta --batchSize=64
