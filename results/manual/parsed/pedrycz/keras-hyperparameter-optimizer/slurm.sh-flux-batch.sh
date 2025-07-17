#!/bin/bash
#FLUX: --job-name=stanky-staircase-7842
#FLUX: --queue=plgrid-gpu
#FLUX: -t=36000
#FLUX: --urgency=16

module purge
module load plgrid/tools/python-intel
module load plgrid/apps/cuda
THEANO_FLAGS='device=gpu,floatX=float32,lib.cnmem=1.0' python -m optimizer_genetic.py
