#!/bin/bash
#FLUX: --job-name=drag-force
#FLUX: -n=256
#FLUX: --queue=normal
#FLUX: -t=43200
#FLUX: --urgency=16

ulimit -c 0
set -x
ibrun python drag-force-mla.py
