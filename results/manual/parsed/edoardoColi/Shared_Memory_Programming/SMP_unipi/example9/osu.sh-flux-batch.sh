#!/bin/bash
#FLUX: --job-name=fat-underoos-4335
#FLUX: -n=2
#FLUX: --priority=16

echo "Test executed on: $SLURM_JOB_NODELIST"
mpirun -n 2 --report-bindings /opt/ohpc/pub/mpi/osu-7.4/pt2pt/osu_bw 2>&1
echo "done"
