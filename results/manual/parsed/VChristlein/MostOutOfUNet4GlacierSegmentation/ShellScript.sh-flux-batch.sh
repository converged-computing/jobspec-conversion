#!/bin/bash
#FLUX: --job-name=[1.0,0.0]Glacier
#FLUX: -c=2
#FLUX: --priority=16

export PATH='/cluster/yr14ofit/miniconda/bin:$PATH'

export PATH=/cluster/yr14ofit/miniconda/bin:$PATH
which python
python main.py --parameter=hyperparameters/hyperparameters_reference.yaml
