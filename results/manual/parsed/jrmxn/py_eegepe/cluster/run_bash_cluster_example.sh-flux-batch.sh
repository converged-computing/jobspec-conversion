#!/bin/bash
#FLUX: --job-name=s00
#FLUX: -c=3
#FLUX: -t=43200
#FLUX: --urgency=16

module load tensorflow/anaconda3-5.1.0
pip install numpy scipy pandas matplotlib seaborn fooof pycircstat noisyopt pykalman sympy keras
python cluster_functions.py --ix_sub 0 --arch net_sgd_005 --function run_main_across_subjects --epochs 500 --es_patience 5
