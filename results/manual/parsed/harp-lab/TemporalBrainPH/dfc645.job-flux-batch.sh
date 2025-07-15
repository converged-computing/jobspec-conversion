#!/bin/bash
#FLUX: --job-name=dfc645
#FLUX: -c=16
#FLUX: --queue=amd-hdr100
#FLUX: -t=50400
#FLUX: --priority=16

set -e
source /home/ashovon/newaumri/matfiles/venv/bin/activate
python -u /home/ashovon/newaumri/matfiles/TemporalBrainPH/distance_calculation.py --data 645 --method ws --start 1 --end 316 --distance y --mds y
