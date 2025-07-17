#!/bin/bash
#FLUX: --job-name=gassy-itch-2116
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python custom_cnn.py
