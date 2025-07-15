#!/bin/bash
#FLUX: --job-name=test
#FLUX: --queue=savio2
#FLUX: -t=300
#FLUX: --priority=16

module load python/3.9.12
python calc.py >& calc.out
