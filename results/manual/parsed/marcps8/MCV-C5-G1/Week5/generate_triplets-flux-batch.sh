#!/bin/bash
#FLUX: --job-name=crunchy-muffin-4212
#FLUX: -n=8
#FLUX: --queue=mlow,mlow
#FLUX: --urgency=16

python triplets_generator.py
