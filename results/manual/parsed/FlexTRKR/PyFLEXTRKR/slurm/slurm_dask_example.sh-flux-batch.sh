#!/bin/bash
#FLUX: --job-name=celltracking
#FLUX: -n=16
#FLUX: --exclusive
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

date
conda activate /global/common/software/m1867/python/flextrkr
cd /global/homes/f/feng045/program/PyFLEXTRKR
python ./runscripts/run_celltracking.py ./config/config_csapr500m_example.yml
date
