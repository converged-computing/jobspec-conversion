#!/bin/bash
#FLUX: --job-name=pc_var
#FLUX: -t=18000
#FLUX: --priority=16

module load python/3.9
module load py-pandas/1.3.1_py39
module load py-scikit-learn/1.0.2_py39
module load py-numpy/1.20.3_py39
module load viz 
module load rust/1.63.0
pip install gseapy
python3 s6_find_var.py 
