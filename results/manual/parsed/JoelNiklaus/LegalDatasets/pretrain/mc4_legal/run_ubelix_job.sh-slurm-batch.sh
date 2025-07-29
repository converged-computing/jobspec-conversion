#!/bin/bash
#FLUX: --job-name=Filter MC4
#FLUX: --queue=epyc2
#FLUX: -t=1296000
#FLUX: --urgency=16

python filter_mc4.py
