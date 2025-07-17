#!/bin/bash
#FLUX: --job-name=clusteringresult_nontda
#FLUX: -c=12
#FLUX: --queue=amd-hdr100
#FLUX: -t=14400
#FLUX: --urgency=16

set -e
source /home/ashovon/newaumri/matfiles/venv/bin/activate
python -u /home/ashovon/newaumri/matfiles/TemporalBrainPH/cluster_calculation_nontda.py
