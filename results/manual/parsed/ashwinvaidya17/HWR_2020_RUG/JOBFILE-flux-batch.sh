#!/bin/bash
#FLUX: --job-name=HWR-Group5
#FLUX: --queue=gpu
#FLUX: -t=18000
#FLUX: --priority=16

module load Python/3.7.4-GCCcore-8.3.0
module load TensorFlow/2.1.0-fosscuda-2019b-Python-3.7.4
python -m pip install -r requirements.txt --user
python ./main.py --image ./test_images
