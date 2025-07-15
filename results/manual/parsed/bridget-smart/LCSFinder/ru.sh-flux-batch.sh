#!/bin/bash
#FLUX: --job-name=hairy-car-4187
#FLUX: -t=3600
#FLUX: --urgency=16

pip install -U datetime pandas numpy warnings numba seaborn matplotlib tqdm
swig -c++ -python LCSFinder.i 
python setup.py build_ext --inplace
python testing_p.py
