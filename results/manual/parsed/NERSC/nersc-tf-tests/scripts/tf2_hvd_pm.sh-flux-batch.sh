#!/bin/bash
#FLUX: --job-name=spicy-platanos-8342
#FLUX: -c=32
#FLUX: --urgency=16

module list
set -x
srun -l -u python horovod/examples/tensorflow2/tensorflow2_synthetic_benchmark.py
