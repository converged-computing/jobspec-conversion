#!/bin/bash
#FLUX: --job-name=lovable-leader-5175
#FLUX: --queue=dgx
#FLUX: -t=1800
#FLUX: --urgency=16

python3 gpu.py P-n16-k8 2000 450 20 60 30
