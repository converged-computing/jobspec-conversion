#!/bin/bash
#FLUX: --job-name=fugly-knife-4265
#FLUX: --queue=debug-gpu
#FLUX: -t=14400
#FLUX: --urgency=16

python Supersense_semeval.py
