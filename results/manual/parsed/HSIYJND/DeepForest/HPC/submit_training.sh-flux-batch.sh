#!/bin/bash
#FLUX: --job-name=DeepForest
#FLUX: -c=5
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

export PYTHONPATH='/apps/geos/3.6.2/lib/python3.6/site-packages:/home/b.weinstein/miniconda3/envs/DeepForest/lib/python3.6/site-packages/'

ml git
ml tensorflow/1.10.1
ml geos/3.6.2
export PYTHONPATH=/apps/geos/3.6.2/lib/python3.6/site-packages:/home/b.weinstein/miniconda3/envs/DeepForest/lib/python3.6/site-packages/
echo $PYTHONPATH
cd /home/b.weinstein/DeepForest
python train.py --mode train
