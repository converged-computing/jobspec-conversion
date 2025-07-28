#!/bin/bash
#FLUX: --job-name=test
#FLUX: --queue=savio2
#FLUX: -t=30
#FLUX: --urgency=16

module load python/3.6
python calc.py >& calc.out
