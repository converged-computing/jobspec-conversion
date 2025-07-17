#!/bin/bash
#FLUX: --job-name=e17b
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=50400
#FLUX: --urgency=16

module purge
module load cuda/8.0.44
module load cudnn/8.0v5.1
module load ffmpeg/intel/3.2.2
source ~/.bashrc
unset XDG_RUNTIME_DIR
cd ~/repos/multif0/deepsalience
python multif0_exper17_batchin.py
