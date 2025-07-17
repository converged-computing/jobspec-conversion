#!/bin/bash
#FLUX: --job-name=cowy-banana-5115
#FLUX: -c=4
#FLUX: -t=480
#FLUX: --urgency=16

module load python/3 gcc arrow cuda cudnn
virtualenv --no-download tensorflow
source tensorflow/bin/activate
pip install --no-index tensorflow==2.8
pip install -r ./../requirements.txt
pip install -e ./../
python ./test-parameters.py
