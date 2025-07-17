#!/bin/bash
#FLUX: --job-name=wobbly-salad-0947
#FLUX: --queue=pleiades
#FLUX: --urgency=16

module load node
python getWaits.py
