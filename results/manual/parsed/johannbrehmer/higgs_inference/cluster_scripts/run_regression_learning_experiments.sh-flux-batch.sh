#!/bin/bash
#FLUX: --job-name=regr-learning
#FLUX: -t=604800
#FLUX: --urgency=16

module purge
module load jupyter-kernels/py2.7
module load scikit-learn/intel/0.18.1
module load theano/0.9.0
module load tensorflow/python2.7/20170707
module load keras/2.0.2
cd /home/jb6504/higgs_inference/higgs_inference
python -u experiments.py regression -o largebatch
python -u experiments.py regression -o largebatch fastlearning
python -u experiments.py regression -o largebatch slowlearning
python -u experiments.py regression -o fastlearning
python -u experiments.py regression -o slowlearning
python -u experiments.py regression -o smallbatch
python -u experiments.py regression -o smallbatch fastlearning
python -u experiments.py regression -o smallbatch slowlearning
python -u experiments.py regression -o largebatch constantlr
python -u experiments.py regression -o largebatch fastlearning constantlr
python -u experiments.py regression -o largebatch slowlearning constantlr
python -u experiments.py regression -o constantlr
python -u experiments.py regression -o fastlearning constantlr
python -u experiments.py regression -o slowlearning constantlr
python -u experiments.py regression -o smallbatch constantlr
python -u experiments.py regression -o smallbatch fastlearning constantlr
python -u experiments.py regression -o smallbatch slowlearning constantlr
