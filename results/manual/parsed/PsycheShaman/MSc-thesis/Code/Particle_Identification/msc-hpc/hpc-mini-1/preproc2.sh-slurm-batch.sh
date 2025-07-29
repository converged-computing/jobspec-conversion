#!/bin/bash
#FLUX: --job-name=CNN3
#FLUX: -n=16
#FLUX: --queue=ada
#FLUX: -t=252000
#FLUX: --urgency=16

module load python/anaconda-python-3.7
python -u /home/vljchr004/hpc-mini/preproc3.py > out_preproc4.txt
