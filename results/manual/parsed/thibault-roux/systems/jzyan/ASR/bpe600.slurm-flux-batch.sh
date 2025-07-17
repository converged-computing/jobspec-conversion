#!/bin/bash
#FLUX: --job-name=bpe600
#FLUX: -c=10
#FLUX: -t=358200
#FLUX: --urgency=16

python train.py hparams/bpe80.yaml --data_parallel_backend
