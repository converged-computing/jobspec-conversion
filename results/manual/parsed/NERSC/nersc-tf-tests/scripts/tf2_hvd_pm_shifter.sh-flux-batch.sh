#!/bin/bash
#FLUX: --job-name=tf2-benchmark-pm-shifter
#FLUX: -c=32
#FLUX: -t=300
#FLUX: --urgency=16

set -x
srun -l -u --mpi=pmi2 shifter \
    bash -c "python horovod/examples/tensorflow2/tensorflow2_synthetic_benchmark.py"
