#!/bin/bash
#FLUX: --job-name=bumfuzzled-peanut-butter-3451
#FLUX: --urgency=16

module purge
module load gcc cuda python-env/3.6.3-ml
SRCDIR=/homeappl/home/celikkan/Github/BERT-prosody
DATADIR=$SRCDIR/data
python  $SRCDIR/main.py --datadir $DATADIR --number_of_sents 33050 --model Regression
