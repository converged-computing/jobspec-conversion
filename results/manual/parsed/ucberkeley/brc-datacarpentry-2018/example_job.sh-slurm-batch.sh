#!/bin/bash
#FLUX: --job-name=test
#FLUX: -n=48
#FLUX: --queue=savio2
#FLUX: -t=1800
#FLUX: --urgency=16

module load python/3.6
python calc.py >& calc.out
