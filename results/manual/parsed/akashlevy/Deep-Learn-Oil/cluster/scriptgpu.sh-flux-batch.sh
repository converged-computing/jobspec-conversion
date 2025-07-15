#!/bin/bash
#FLUX: --job-name=grated-toaster-7136
#FLUX: --priority=16

THEANO_FLAGS=mode=FAST_RUN,device=gpu,floatX=float32 python fcn.py
