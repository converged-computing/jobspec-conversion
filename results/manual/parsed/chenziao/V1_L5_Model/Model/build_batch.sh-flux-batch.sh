#!/bin/bash
#FLUX: --job-name=wobbly-staircase-4231
#FLUX: --priority=16

START=$(date)
echo "Started running at $START."
unset DISPLAY
python build_network.py #srun
END=$(date)
echo "Done running simulation at $END"
