#!/bin/bash
#FLUX: --job-name=dfc2500
#FLUX: -c=6
#FLUX: --queue=amd-hdr100
#FLUX: -t=14400
#FLUX: --priority=16

set -e
source /home/ashovon/newaumri/matfiles/venv/bin/activate
python -u /home/ashovon/newaumri/matfiles/TemporalBrainPH/distance_calculation.py --data 2500 --method bn --start 1 --end 316 --distance y --mds y
