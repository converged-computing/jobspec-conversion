#!/bin/bash
#FLUX --job-name=outstanding-sundae-1868
#FLUX -c=64
#FLUX --queue=amd_1T
#FLUX --urgency=16

python -u DNN_SingleBubble.py # CUDA / MPI
python -u BubbleNet_SingleBubble.py
