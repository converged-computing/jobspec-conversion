#!/bin/bash
#FLUX: --job-name=phat-fudge-3387
#FLUX: -n=12
#FLUX: --queue=plgrid
#FLUX: -t=3600
#FLUX: --urgency=16

module add plgrid/tools/python-intel/3.6.5 2>/dev/null
mpiexec -n 1 ./zad1.py 7
