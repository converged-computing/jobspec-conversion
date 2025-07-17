#!/bin/bash
#FLUX: --job-name=expensive-punk-1153
#FLUX: -N=2
#FLUX: -n=2
#FLUX: --queue=normal
#FLUX: -t=300
#FLUX: --urgency=16

echo "Test executed on: $SLURM_JOB_NODELIST"
mpirun -n 2 --report-bindings /opt/ohpc/pub/mpi/osu-7.4/pt2pt/osu_bw 2>&1
echo "done"
