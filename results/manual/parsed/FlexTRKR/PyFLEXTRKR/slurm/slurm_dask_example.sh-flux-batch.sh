#!/bin/bash
#FLUX: --job-name=tart-pedo-8412
#FLUX: --exclusive
#FLUX: --priority=16

date
conda activate /global/common/software/m1867/python/flextrkr
cd /global/homes/f/feng045/program/PyFLEXTRKR
python ./runscripts/run_celltracking.py ./config/config_csapr500m_example.yml
date
