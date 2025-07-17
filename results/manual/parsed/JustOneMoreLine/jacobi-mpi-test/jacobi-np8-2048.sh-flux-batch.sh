#!/bin/bash
#FLUX: --job-name=buttery-sundae-4839
#FLUX: -N=8
#FLUX: --queue=batch
#FLUX: --urgency=16

mpirun --mca btl_tcp_if_exclude docker0,lo -np 8 jacobi-np8-2048 -- 2048 10000
