#!/bin/bash
#FLUX: --job-name=hairy-hobbit-9766
#FLUX: -t=1800
#FLUX: --urgency=16

export THEANO_FLAGS='floatX=float64'

module load python/3.5.1
export THEANO_FLAGS='floatX=float64'
python train.py $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10}
