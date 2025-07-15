#!/bin/bash
#FLUX: --job-name=fuzzy-car-4639
#FLUX: --urgency=16

python -u DNN_SingleBubble.py # CUDA / MPI
python -u BubbleNet_SingleBubble.py
