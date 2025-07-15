#!/bin/bash
#FLUX: --job-name=chocolate-cinnamonbun-6688
#FLUX: -c=32
#FLUX: --priority=16

set -x
srun -l -u --mpi=pmi2 shifter \
    bash -c "python horovod/examples/tensorflow2/tensorflow2_synthetic_benchmark.py"
