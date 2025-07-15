#!/bin/bash
#FLUX: --job-name=frigid-malarkey-2532
#FLUX: --priority=16

mpirun --mca btl_tcp_if_exclude docker0,lo -np 5 jacobi-mpi 512 100
