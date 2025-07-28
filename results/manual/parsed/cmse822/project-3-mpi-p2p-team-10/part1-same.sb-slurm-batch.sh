#!/bin/bash
#FLUX: --job-name=HW3-BLOCKING-SAME
#FLUX: --exclusive
#FLUX: -t=60
#FLUX: --urgency=16

module purge
module load intel/2021a
cd /mnt/home/kamalida/cmse822/project-3-mpi-p2p-team-10                   ### change to the directory where your code is located
mpicxx ./ping-ping-blocking.c -o ping-ping-blocking.out
mpiexec -n 2 ./ping-ping-blocking.out
scontrol show job $SLURM_JOB_ID     ### write job information to output file
