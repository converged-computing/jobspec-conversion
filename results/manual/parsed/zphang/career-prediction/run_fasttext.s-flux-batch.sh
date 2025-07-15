#!/bin/bash
#FLUX: --job-name=fasttext
#FLUX: -t=36600
#FLUX: --urgency=16

module load pytorch/python3.6/0.2.0_3
source activate jobembeddings
RUNDIR=$SCRATCH/data/jobembeddings
$RUNDIR/fastText/fasttext supervised -input $RUNDIR/json_sample10m_fasttext_train -output $RUNDIR/fasttext_10m_model
