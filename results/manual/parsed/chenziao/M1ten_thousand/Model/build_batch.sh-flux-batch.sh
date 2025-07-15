#!/bin/bash
#FLUX: --job-name=buttery-puppy-9859
#FLUX: --priority=16

START=$(date)
echo "Started running at $START."
unset DISPLAY
python build_network.py #srun
END=$(date)
echo "Done running simulation at $END"
