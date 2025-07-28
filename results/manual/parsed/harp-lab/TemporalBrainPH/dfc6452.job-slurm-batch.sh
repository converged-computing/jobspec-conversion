#!/bin/bash
#FLUX: --job-name=dfc6452
#FLUX: -c=4
#FLUX: --queue=amd-hdr100
#FLUX: -t=57600
#FLUX: --urgency=16

set -e
source /home/ashovon/newaumri/matfiles/venv/bin/activate
python -u /home/ashovon/newaumri/matfiles/TemporalBrainPH/distance_calculation.py --data 645 --method bn --start 100 --end 150 --distance y --mds n
