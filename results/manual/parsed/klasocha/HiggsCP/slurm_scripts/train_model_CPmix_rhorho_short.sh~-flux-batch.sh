#!/bin/bash
#FLUX: --job-name=phat-blackbean-1944
#FLUX: -t=57600
#FLUX: --priority=16

export PYTHONPATH='$ANACONDA_PYTHON_PATH'

if [ -f setup ]; then source setup; fi
export PYTHONPATH=$ANACONDA_PYTHON_PATH
module add plgrid/apps/cuda/7.5
cd $WORKDIR
echo "TrainCPmix Job. Dropout 0.2. RHORHO"
$ANACONDA_PYTHON_PATH/python2.7 $WORKDIR/main.py -t nn_rhorho_CPmix -i $RHORHO_DATA -e 5 -f Model-OnlyHad -d 0.2 -l 6 -s 300 --unweighted True
