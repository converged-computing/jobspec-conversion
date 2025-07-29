#!/bin/bash
#FLUX: --job-name=fairnas
#FLUX: -c=8
#FLUX: --queue=ml_gpu-rtx2080
#FLUX: -t=518400
#FLUX: --urgency=16

python src/search/search.py --dataset CelebA
