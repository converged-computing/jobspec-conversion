#!/bin/bash
#FLUX: --job-name=DSB17
#FLUX: -N=2
#FLUX: -t=18000
#FLUX: --priority=16

module purge
module load scikit-learn/intel/0.18.1
module load tensorflow/python2.7/20170218
module list
cd $SCRATCH
cd lung-cancer-detector
python run.py
