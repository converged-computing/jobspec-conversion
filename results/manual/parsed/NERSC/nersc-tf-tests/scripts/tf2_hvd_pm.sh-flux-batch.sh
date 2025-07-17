#!/bin/bash
#FLUX: --job-name=tf2-benchmark-pm
#FLUX: -c=32
#FLUX: -t=300
#FLUX: --urgency=16

module list
set -x
srun -l -u python horovod/examples/tensorflow2/tensorflow2_synthetic_benchmark.py
