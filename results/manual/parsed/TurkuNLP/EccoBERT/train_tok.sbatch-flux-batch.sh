#!/bin/bash
#FLUX: --job-name=tok
#FLUX: -c=8
#FLUX: --queue=medium
#FLUX: -t=25200
#FLUX: --priority=16

module load pytorch/1.9
singularity_wrapper exec python3 train_tokenizer.py --filelist $1 --N 10000 --out $2
