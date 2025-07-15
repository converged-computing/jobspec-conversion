#!/bin/bash
#FLUX: --job-name=wobbly-poo-0059
#FLUX: --priority=16

ulimit -c 0
set -x
ibrun python drag-force-mla.py
