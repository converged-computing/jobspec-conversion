#!/bin/bash
#FLUX: --job-name=test
#FLUX: --queue=savio2
#FLUX: -t=300
#FLUX: --urgency=16

module load python/3.7
python calc.py >& calc.out
