#!/bin/bash
#FLUX: --job-name=bsc-cnn-job
#FLUX: -c=8
#FLUX: --queue=brown
#FLUX: -t=19800
#FLUX: --urgency=16

module load Anaconda3/2023.03-1
cd "/home/nizp/BSc-Project/ResNet50" 
source activate bachelor
SECONDS=0
echo "Running on $(hostname):"
python cnn_with_val.py
duration=$SECONDS
echo "All models took $(($duration / 60)) minutes and $(($duration % 60)) seconds to train."
