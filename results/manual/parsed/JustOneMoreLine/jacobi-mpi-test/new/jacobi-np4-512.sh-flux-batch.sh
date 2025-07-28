#!/bin/bash
#FLUX: --job-name=peachy-pancake-2803
#FLUX: --queue=batch
#FLUX: --urgency=16

mpirun --mca btl_tcp_if_exclude docker0,lo -np 5 jacobi-mpi 512 100
