#!/bin/bash
#FLUX: --job-name=dfc645_mds
#FLUX: -c=16
#FLUX: --queue=amd-hdr100
#FLUX: -t=28800
#FLUX: --urgency=16

set -e
source /home/ashovon/newaumri/matfiles/venv/bin/activate
python -u /home/ashovon/newaumri/matfiles/TemporalBrainPH/distance_calculation.py --data 645 --method bn --start 1 --end 316 --distance n --mds y
