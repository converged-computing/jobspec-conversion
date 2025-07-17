#!/bin/bash
#FLUX: --job-name=scruptious-diablo-7944
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python retrieval.py
