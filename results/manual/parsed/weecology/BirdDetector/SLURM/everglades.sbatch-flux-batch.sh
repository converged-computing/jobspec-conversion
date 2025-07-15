#!/bin/bash
#FLUX: --job-name=birddetector
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=43200
#FLUX: --urgency=16

source activate Zooniverse_pytorch
cd ~/BirdDetector/
python utils/everglades_mini.py
