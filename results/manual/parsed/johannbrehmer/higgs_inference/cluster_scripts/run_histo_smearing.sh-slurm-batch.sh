#!/bin/bash
#FLUX: --job-name=histo-smearing
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
module load jupyter-kernels/py2.7
module load scikit-learn/intel/0.18.1
cd /home/jb6504/higgs_inference/higgs_inference
python -u experiments.py histo --smearing --neyman -x 1 41 -o neyman2 asymmetricbinning
