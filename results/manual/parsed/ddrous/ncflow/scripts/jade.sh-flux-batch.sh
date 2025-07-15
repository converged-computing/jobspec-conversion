#!/bin/bash
#FLUX: --job-name=nodepint
#FLUX: -t=3600
#FLUX: --priority=16

nvidia-smi
python3 graphpint/tests/jax_test.py
