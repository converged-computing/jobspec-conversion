#!/bin/bash
#FLUX: --job-name=strawberry-punk-2384
#FLUX: --priority=16

module purge
module load gcc cuda python-env/3.6.3-ml
SRCDIR=/homeappl/home/celikkan/Github/BERT-prosody
DATADIR=$SRCDIR/data
python  $SRCDIR/main.py --datadir $DATADIR --number_of_sents 100 --model Regression
