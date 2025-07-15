#!/bin/bash
#FLUX: --job-name=butterscotch-lentil-2878
#FLUX: --priority=16

python metric_learning.py --arch-type siamese --epochs 200 --process eval
