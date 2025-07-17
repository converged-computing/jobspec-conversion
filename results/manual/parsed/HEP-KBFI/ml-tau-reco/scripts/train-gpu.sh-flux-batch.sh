#!/bin/bash
#FLUX: --job-name=outstanding-punk-0590
#FLUX: --queue=gpu
#FLUX: --urgency=16

IMG=/home/software/singularity/pytorch.simg
cd ~/ml-tau-reco
singularity exec -B /scratch/persistent --nv $IMG \
  python3 src/endtoend_simple.py
