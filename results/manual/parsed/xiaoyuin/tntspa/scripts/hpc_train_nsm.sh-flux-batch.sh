#!/bin/bash
#FLUX: --job-name=lovable-avocado-0043
#FLUX: -c=6
#FLUX: -t=86400
#FLUX: --urgency=16

module load TensorFlow/1.8.0-foss-2018a-Python-3.6.4-CUDA-9.2.88
DDIR=data/monument_600
MDIR=output/models
if [ -n "$1" ]
    then DDIR=$1
fi
if [ -n "$2" ]
    then MDIR=$2
fi
srun python3 -m nmt.nmt.nmt \
    --src=en --tgt=sparql \
    --hparams_path=nmt_hparams/neural_sparql_machine.json \
    --out_dir=$MDIR/neural_sparql_machine \
    --vocab_prefix=$DDIR/vocab \
    --train_prefix=$DDIR/train \
    --dev_prefix=$DDIR/dev \
    --test_prefix=$DDIR/test
exit 0
