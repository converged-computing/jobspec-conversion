#!/bin/bash
#FLUX: --job-name=dirty-chip-8120
#FLUX: --queue=batch
#FLUX: -t=3600
#FLUX: --urgency=16

pip install -U datetime pandas numpy warnings numba seaborn matplotlib tqdm
swig -c++ -python LCSFinder.i 
python setup.py build_ext --inplace
python testing_p.py
