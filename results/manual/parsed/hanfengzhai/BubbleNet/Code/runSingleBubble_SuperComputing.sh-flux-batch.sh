#!/bin/bash
#FLUX: --job-name=outstanding-train-0198
#FLUX: --priority=16

python -u DNN_SingleBubble.py # CUDA / MPI
python -u BubbleNet_SingleBubble.py
