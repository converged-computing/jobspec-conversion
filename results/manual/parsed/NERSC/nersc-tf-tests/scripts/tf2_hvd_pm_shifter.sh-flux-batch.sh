#!/bin/bash
#FLUX: --job-name=rainbow-cupcake-1642
#FLUX: -c=32
#FLUX: --urgency=16

set -x
srun -l -u --mpi=pmi2 shifter \
    bash -c "python horovod/examples/tensorflow2/tensorflow2_synthetic_benchmark.py"
