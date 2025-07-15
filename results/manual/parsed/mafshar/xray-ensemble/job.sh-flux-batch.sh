#!/bin/bash
#FLUX: --job-name=chest-xray
#FLUX: -t=604800
#FLUX: --priority=16

module purge
module load numpy/intel/1.13.1
module load scikit-image/intel/0.13.1
module load scipy/intel/0.19.1
module load scikit-learn/intel/0.18.1
module load tensorflow/python2.7/1.3.0
cd /scratch/ma2510/dsh/xray-ensemble
python src/main.py
