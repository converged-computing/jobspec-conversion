#!/bin/bash
#FLUX: --job-name=nodepint
#FLUX: -t=36000
#FLUX: --priority=16

python3 ./scripts/jax_test.py
