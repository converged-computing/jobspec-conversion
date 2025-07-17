#!/bin/bash
#FLUX: --job-name=stinky-pancake-6664
#FLUX: --queue=holyseasgpu
#FLUX: -t=3600
#FLUX: --urgency=16

THEANO_FLAGS=mode=FAST_RUN,device=gpu,floatX=float32 python fcn.py
