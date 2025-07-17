#!/bin/bash
#FLUX: --job-name=creamy-fork-4183
#FLUX: -c=16
#FLUX: --queue=shared
#FLUX: -t=3600
#FLUX: --urgency=16

module load cesga/2018 gcc/6.4.0 pandas/1.0.0-python-3.8.1 scipy/1.4.1-python-3.8.1 tensorflow/2.2.1-python-3.8.1
python pipeline_classif.py
