#!/bin/bash
#FLUX: --job-name=outstanding-plant-5237
#FLUX: --urgency=16

ulimit -c 0
set -x
ibrun python drag-force-mla.py
