#!/bin/bash
#FLUX: --job-name=buttery-animal-9046
#FLUX: -c=32
#FLUX: --priority=16

module list
set -x
srun -l -u python horovod/examples/tensorflow2/tensorflow2_synthetic_benchmark.py
