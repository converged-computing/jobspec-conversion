#!/bin/bash
#FLUX: --job-name=randomcluster_2
#FLUX: -c=12
#FLUX: --queue=amd-hdr100
#FLUX: -t=36000
#FLUX: --urgency=16

set -e
source /home/ashovon/venvs/brainph/bin/activate
python -u /home/ashovon/brainPH/cluster_calculation_random.py
