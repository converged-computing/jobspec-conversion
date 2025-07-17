#!/bin/bash
#FLUX: --job-name=DeepForest
#FLUX: -c=5
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

export PYTHONPATH='${PYTHONPATH}:/home/b.weinstein/miniconda/envs/DeepForest/lib/python3.6/site-packages/'

ml git
ml tensorflow/1.10.1
ml geos/3.6.2
sleep 10
module list
echo $PYTHONPATH
export PYTHONPATH=${PYTHONPATH}:/home/b.weinstein/miniconda/envs/DeepForest/lib/python3.6/site-packages/
echo $PYTHONPATH
cd /home/b.weinstein/DeepForest
python train.py --mode retrain
