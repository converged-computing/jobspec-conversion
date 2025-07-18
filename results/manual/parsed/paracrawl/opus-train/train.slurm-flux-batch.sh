#!/bin/bash
#FLUX: --job-name=blank-pastry-8553
#FLUX: --queue=pascal
#FLUX: -t=86400
#FLUX: --urgency=16

if [ "$1" == "-h" ]
then
    echo "Train Marian model"
    echo "Usage: sbatch [params] `basename $0` <lang1> <lang2> <corpus_train>"
    exit 0
fi
. /etc/profile.d/modules.sh
module purge
module load rhel7/default-peta4
module load python/3.7
module load cuda/10.1
source ./venv/bin/activate
MARIAN=~/rds/rds-t2-cs119/cs-zara1/marian-dev/build
L1=$1
L2=$2
CORPUS=$3
CONFIG=config/base.yml
MODELS=models
LOGS=logs
if [ -d data/$L1-$L2 ]; then
    DATA=data/$L1-$L2
else
    DATA=data/$L2-$L1
fi
MODELNAME=$CORPUS.`basename ${CONFIG%.yml}`
mkdir -p $MODELS
$MARIAN/marian \
    -m $MODELS/$L1$L2.$MODELNAME.npz \
    -v $MODELS/vocab.$L1$L2.$MODELNAME.spm $MODELS/vocab.$L1$L2.$MODELNAME.spm \
    -t $DATA/$CORPUS.$L1.gz $DATA/$CORPUS.$L2.gz \
    --valid-sets $DATA/dev.$L1 $DATA/dev.$L2 \
    -c $CONFIG \
    -d ${CUDA_VISIBLE_DEVICES//,/ } \
    --log $LOGS/train.$MODELNAME.$L1$L2.log --valid-log $LOGS/valid.$MODELNAME.$L1$L2.log
