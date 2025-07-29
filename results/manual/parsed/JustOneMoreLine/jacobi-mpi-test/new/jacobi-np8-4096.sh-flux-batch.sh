#!/bin/bash
#FLUX --job-name=expensive-banana-8878
#FLUX --queue=batch
#FLUX --urgency=16

mpirun --mca btl_tcp_if_exclude docker0,lo -np 8 jacobi-mpi 4095 100
