#!/bin/bash
#FLUX: --job-name=goodbye-train-7587
#FLUX: -t=57600
#FLUX: --priority=16

export PYTHONPATH='$ANACONDA_PYTHON_PATH'

if [ -f setup ]; then source setup; fi
export PYTHONPATH=$ANACONDA_PYTHON_PATH
module add plgrid/apps/cuda/7.5
cd $WORKDIR
echo "TrainCPmix Job. Dropout 0.2. RHORHO"
$ANACONDA_PYTHON_PATH/python2.7 $WORKDIR/main.py -t nn_rhorho_CPmix -i $RHORHO_DATA -e 5 -f Variant-1.0 -d 0.2 -l 6 -s 300
