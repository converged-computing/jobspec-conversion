#!/bin/bash
#FLUX: --job-name=test_model
#FLUX: -n=4
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

cd /scratch/user/kevin83427/TRN-pytorch
module load Anaconda/3-5.0.0.1
source activate pytorch
./train.sh
