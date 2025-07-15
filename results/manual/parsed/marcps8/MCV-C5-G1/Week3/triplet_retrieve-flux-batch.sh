#!/bin/bash
#FLUX: --job-name=strawberry-leopard-2505
#FLUX: --urgency=16

python metric_learning.py --arch-type triplet --process retrieve
