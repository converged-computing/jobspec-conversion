#!/bin/bash
#FLUX: --job-name=rainbow-hippo-5139
#FLUX: -c=8
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$(pwd)/install/lib:$(pwd)/install/lib64'

module load gcc cmake
source /home/qyan/venvtranspose/bin/activate
cd opencv-build
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(pwd)/install/lib:$(pwd)/install/lib64
python3 -c "import torch; import dsacstar"
echo start at `date`
python3 /home/qyan/TransPose/script/foo.py
echo finished at `date`
