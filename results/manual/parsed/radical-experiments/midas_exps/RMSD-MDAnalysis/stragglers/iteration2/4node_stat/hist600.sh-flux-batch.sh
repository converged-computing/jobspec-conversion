#!/bin/bash
#FLUX: --job-name=eccentric-ricecake-4402
#FLUX: --priority=16

cd /data/03170/tg824689/BecksteinLab/scripts-DCD
source activate daskMda
python hist300.py
