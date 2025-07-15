#!/bin/bash
#FLUX: --job-name=moolicious-truffle-5398
#FLUX: -n=2
#FLUX: --urgency=16

echo "Test executed on: $SLURM_JOB_NODELIST"
mpirun -n 2 --report-bindings /opt/ohpc/pub/mpi/osu-7.4/pt2pt/osu_bw 2>&1
echo "done"
