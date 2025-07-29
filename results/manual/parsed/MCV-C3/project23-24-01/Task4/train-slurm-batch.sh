#!/bin/bash
#FLUX: --job-name=wobbly-cupcake-5614
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python custom_cnn.py
