#!/bin/bash
#FLUX: --job-name=moolicious-peanut-butter-1227
#FLUX: --queue=standard
#FLUX: -t=86400
#FLUX: --urgency=16

source activate /home/apps/DL/DL-CondaPy3.7
python cmb.py
