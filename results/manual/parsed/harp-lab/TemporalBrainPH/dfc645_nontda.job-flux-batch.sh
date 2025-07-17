#!/bin/bash
#FLUX: --job-name=dfc645_nontda
#FLUX: -c=4
#FLUX: --queue=amd-hdr100
#FLUX: -t=36000
#FLUX: --urgency=16

set -e
source /home/ashovon/newaumri/matfiles/venv/bin/activate
python -u /home/ashovon/newaumri/matfiles/TemporalBrainPH/non_tda_distance_calculation.py --data 645 --method eu --start 1 --end 316 --distance y --mds y
