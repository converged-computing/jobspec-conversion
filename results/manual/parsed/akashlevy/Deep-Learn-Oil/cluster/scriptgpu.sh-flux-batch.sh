#!/bin/bash
#FLUX: --job-name=spicy-lettuce-8153
#FLUX: --urgency=16

THEANO_FLAGS=mode=FAST_RUN,device=gpu,floatX=float32 python fcn.py
