#!/bin/bash
#FLUX --job-name=conspicuous-despacito-4763
#FLUX -c=4
#FLUX --queue=gpuq
#FLUX -t=600
#FLUX --urgency=16

python testTF2.py
