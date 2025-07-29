#!/bin/bash
#FLUX --job-name=lovely-signal-8175
#FLUX --queue=batch
#FLUX -t=3600
#FLUX --urgency=16

pip install -U datetime pandas numpy warnings numba seaborn matplotlib tqdm
swig -c++ -python LCSFinder.i 
python setup.py build_ext --inplace
python testing_p.py
