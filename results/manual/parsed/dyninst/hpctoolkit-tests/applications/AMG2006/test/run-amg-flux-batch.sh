#!/bin/bash
#FLUX: --job-name=butterscotch-pedo-0441
#FLUX: --exclusive
#FLUX: -t=300
#FLUX: --priority=16

export OMP_NUM_THREADS='2'
export OMP_WAIT_POLICY='active'
export KMP_BLOCKTIME='infinite'

module load OpenMPI
export OMP_NUM_THREADS=2
export OMP_WAIT_POLICY=active
export KMP_BLOCKTIME=infinite
srun  -n 4 hpcrun  -o hpctoolkit-all-measurements -e REALTIME@1000 -t ./amg2006 -P 2 2 1 -n 2 2 4  -r 10 10 10
