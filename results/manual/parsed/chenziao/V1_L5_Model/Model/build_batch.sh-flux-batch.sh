#!/bin/bash
#FLUX: --job-name=V1_build
#FLUX: -t=172800
#FLUX: --urgency=16

START=$(date)
echo "Started running at $START."
unset DISPLAY
python build_network.py #srun
END=$(date)
echo "Done running simulation at $END"
