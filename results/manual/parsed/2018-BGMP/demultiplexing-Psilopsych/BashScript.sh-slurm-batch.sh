#!/bin/bash
#FLUX: --job-name=StatsR3
#FLUX: --queue=short
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load easybuild intel/2017a Python/3.6.1; which python
/usr/bin/time python3 posStatsN.py > statsR3.txt
