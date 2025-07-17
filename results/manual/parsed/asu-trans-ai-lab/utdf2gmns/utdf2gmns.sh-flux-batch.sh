#!/bin/bash
#FLUX: --job-name=pusheena-destiny-9951
#FLUX: --queue=normal
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load anaconda/py3
source activate xluo_civ
python utdf2gmns.py
