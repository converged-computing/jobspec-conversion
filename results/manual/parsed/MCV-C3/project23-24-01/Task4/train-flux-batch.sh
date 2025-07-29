#!/bin/bash
#FLUX --job-name=cowy-parrot-6545
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python custom_cnn.py
