#!/bin/bash
#FLUX: --job-name=strawberry-blackbean-3297
#FLUX: -n=8
#FLUX: --queue=mlow,mlow
#FLUX: --urgency=16

python triplets_generator.py
