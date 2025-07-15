#!/bin/bash
#FLUX: --job-name=tart-animal-0641
#FLUX: --urgency=16

python3 gpu.py P-n16-k8 2000 450 20 60 30
