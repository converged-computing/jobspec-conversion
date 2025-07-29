#!/bin/bash
#FLUX: --job-name=CNN17
#FLUX: -n=16
#FLUX: --queue=ada
#FLUX: -t=252000
#FLUX: --urgency=16

module load python/anaconda-python-3.7
module load software/TensorFlow-CPU-py3
python -u /home/vljchr004/msc-hpc/model18.py > out_model18.txt
