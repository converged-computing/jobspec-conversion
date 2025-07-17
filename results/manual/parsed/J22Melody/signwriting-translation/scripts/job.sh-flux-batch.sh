#!/bin/bash
#FLUX: --job-name=baseline
#FLUX: -t=259200
#FLUX: --urgency=16

module load nvidia/cuda11.2-cudnn8.1.0
module load anaconda3
source activate joey
cd tools/joeynmt
pip install -e .
cd ..
cd ..
stdbuf -o0 -e0 srun --unbuffered $1 $2
