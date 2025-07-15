#!/bin/bash
#FLUX: --job-name=sticky-nunchucks-5687
#FLUX: --priority=16

IMG=/home/software/singularity/pytorch.simg
cd ~/ml-tau-reco
singularity exec -B /scratch/persistent --nv $IMG \
  python3 src/endtoend_simple.py
