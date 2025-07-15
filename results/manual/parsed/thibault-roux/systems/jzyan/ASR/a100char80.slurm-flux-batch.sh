#!/bin/bash
#FLUX: --job-name=char80
#FLUX: -c=10
#FLUX: -t=354900
#FLUX: --priority=16

python train.py hparams/char80.yaml --data_parallel_backend
