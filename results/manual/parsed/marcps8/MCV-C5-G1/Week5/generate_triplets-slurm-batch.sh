#!/bin/bash
#FLUX: --job-name=swampy-cattywampus-3048
#FLUX: -n=8
#FLUX: --queue=mlow,mlow
#FLUX: --urgency=16

python triplets_generator.py
