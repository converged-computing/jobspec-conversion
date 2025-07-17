#!/bin/bash
#FLUX: --job-name=main
#FLUX: -n=10
#FLUX: --queue=bch-gpu
#FLUX: -t=108000
#FLUX: --urgency=16

source /programs/biogrids.shrc
python.tensorflow main.py
