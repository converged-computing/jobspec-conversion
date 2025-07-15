#!/bin/bash
#FLUX: --job-name=scruptious-spoon-7921
#FLUX: --priority=16

python metric_learning.py --arch-type triplet --process retrieve
