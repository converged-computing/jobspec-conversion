#!/bin/bash
#FLUX: --job-name=debug
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load jupyter-kernels/py2.7
module load scikit-learn/intel/0.18.1
module load theano/0.9.0
module load tensorflow/python2.7/20170707
module load keras/2.0.2
cd /home/jb6504/higgs_inference/higgs_inference
python -u experiments.py scoreregression -o short
