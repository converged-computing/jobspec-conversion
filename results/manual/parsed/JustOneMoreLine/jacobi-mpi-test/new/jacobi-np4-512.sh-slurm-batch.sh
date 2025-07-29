#!/bin/bash
#FLUX: --job-name=misunderstood-plant-7325
#FLUX: --queue=batch
#FLUX: --urgency=16

mpirun --mca btl_tcp_if_exclude docker0,lo -np 5 jacobi-mpi 512 100
