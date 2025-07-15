#!/bin/bash
#FLUX: --job-name=sticky-buttface-0954
#FLUX: -c=8
#FLUX: -t=82800
#FLUX: --urgency=16

source /home/hkshvrz/projects/def-m2nagapp/hkshvrz/jit-bugpred/venv/bin/activate
which python
module load java/11
unset JAVA_TOOL_OPTIONS
python -u src/gumtree.py
