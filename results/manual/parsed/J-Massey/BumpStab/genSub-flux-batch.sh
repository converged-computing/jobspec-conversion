#!/bin/bash
#FLUX: --job-name=RA
#FLUX: -n=64
#FLUX: --queue=amd
#FLUX: -t=16200
#FLUX: --priority=16

module load texlive
module load conda
source activate an
python resolvent/spDMD.py
python resolvent/resolvent_analysis.py
python resolvent/plot_gain.py
python resolvent/plot_peaks.py
