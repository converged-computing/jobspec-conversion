#!/bin/bash
#FLUX: --job-name=tikho_train
#FLUX: -c=10
#FLUX: -t=72000
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:$WORK/GitHub/score'

module purge
module load tensorflow-gpu/py3/1.15.2
set -x
export PYTHONPATH="$PYTHONPATH:$WORK/GitHub/alpha-transform"
export PYTHONPATH="$PYTHONPATH:$WORK/GitHub/score"
cd $WORK/GitHub/ShapeDeconv/scripts
python ./tikhonet_train_radio_64.py --data_dir=/gpfswork/rech/xdy/uze68md/data/meerkat_3600/ --model_dir=/gpfswork/rech/xdy/uze68md/trained_models/model_meerkat_64/ --n_col=64 --n_row=64 --batch_size=32 --steps=3125 --epochs=10
