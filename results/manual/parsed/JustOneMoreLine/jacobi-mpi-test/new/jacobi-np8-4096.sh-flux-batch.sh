#!/bin/bash
#FLUX: --job-name=faux-pot-4454
#FLUX: --priority=16

mpirun --mca btl_tcp_if_exclude docker0,lo -np 8 jacobi-mpi 4095 100
