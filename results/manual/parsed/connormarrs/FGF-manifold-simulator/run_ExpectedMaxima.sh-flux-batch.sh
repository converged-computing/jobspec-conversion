#!/bin/bash
#FLUX: --job-name=astute-peas-8995
#FLUX: -n=72
#FLUX: --queue=general
#FLUX: -t=41400
#FLUX: --urgency=16

module purge
module load gcc/9.2.0 libffi/3.2.1 bzip2/1.0.6 tcl/8.6.6.8606 sqlite/3.30.1 lzma/4.32.7 
module load python/3.9.2
python3 --version
pip install --user --upgrade pip
pip install --upgrade --user scipy
pip show scipy
python3 python_scripts/expected_means.py
