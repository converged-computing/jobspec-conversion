#!/bin/bash
#FLUX: --job-name=scatter
#FLUX: -n=4
#FLUX: -t=600
#FLUX: --urgency=16

srun time python scatter.py -checksum
