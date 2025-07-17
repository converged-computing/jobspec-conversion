#!/bin/bash
#FLUX: --job-name=hist600
#FLUX: --queue=normal
#FLUX: -t=86400
#FLUX: --urgency=16

cd /data/03170/tg824689/BecksteinLab/scripts-DCD
source activate daskMda
python hist300.py
