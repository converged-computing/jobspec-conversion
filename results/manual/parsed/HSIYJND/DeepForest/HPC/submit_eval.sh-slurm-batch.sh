#!/bin/bash
#FLUX: --job-name=DeepForest
#FLUX: -c=5
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

export PYTHONPATH='${PYTHONPATH}:/home/b.weinstein/miniconda3/envs/DeepForest/lib/python3.6/site-packages/'

ml git
ml geos/3.6.2
ml tensorflow/1.10.1
export PYTHONPATH=${PYTHONPATH}:/home/b.weinstein/miniconda3/envs/DeepForest/lib/python3.6/site-packages/
echo $PYTHONPATH
cd /home/b.weinstein/DeepForest
python eval.py --mode retrain
