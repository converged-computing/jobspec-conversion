#!/bin/bash
#FLUX: --job-name=dfc1400
#FLUX: -c=12
#FLUX: --queue=amd-hdr100
#FLUX: -t=57600
#FLUX: --priority=16

set -e
source /home/ashovon/newaumri/matfiles/venv/bin/activate
python -u /home/ashovon/newaumri/matfiles/TemporalBrainPH/distance_calculation.py --data 1400 --method bn --start 1 --end 150 --distance y --mds y
