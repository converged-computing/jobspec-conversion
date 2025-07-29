#!/bin/bash
#FLUX: --job-name=MyJob
#FLUX: -N=2
#FLUX: -n=16
#FLUX: --queue=ada
#FLUX: -t=252000
#FLUX: --urgency=16

module load python/anaconda-python-3.7
module load software/TensorFlow-CPU-py3
python -u /home/vljchr004/msc-hpc/round4/round4_cnn7.py > out2.txt
