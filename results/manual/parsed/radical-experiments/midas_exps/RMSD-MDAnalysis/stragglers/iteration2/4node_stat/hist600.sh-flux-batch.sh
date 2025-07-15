#!/bin/bash
#FLUX: --job-name=hanky-snack-3274
#FLUX: --urgency=16

cd /data/03170/tg824689/BecksteinLab/scripts-DCD
source activate daskMda
python hist300.py
