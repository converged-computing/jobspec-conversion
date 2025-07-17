#!/bin/bash
#FLUX: --job-name=predict_everglades
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

export PATH='${PATH}:/home/b.weinstein/miniconda3/envs/Zooniverse/bin/'
export PYTHONPATH='${PYTHONPATH}:/home/b.weinstein/miniconda3/envs/Zooniverse/lib/python3.7/site-packages/'
export LD_LIBRARY_PATH='/home/b.weinstein/miniconda3/envs/Zooniverse/lib/:${LD_LIBRARY_PATH}'
export GDAL_DATA='/home/b.weinstein/miniconda3/envs/Zooniverse/share/gdal'

module load tensorflow/1.14.0
export PATH=${PATH}:/home/b.weinstein/miniconda3/envs/Zooniverse/bin/
export PYTHONPATH=${PYTHONPATH}:/home/b.weinstein/miniconda3/envs/Zooniverse/lib/python3.7/site-packages/
export LD_LIBRARY_PATH=/home/b.weinstein/miniconda3/envs/Zooniverse/lib/:${LD_LIBRARY_PATH}
export GDAL_DATA=/home/b.weinstein/miniconda3/envs/Zooniverse/share/gdal
cd /home/b.weinstein/EvergladesWadingBird/Zooniverse
python predict.py
python nest_detection.py
