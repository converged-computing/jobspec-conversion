#!/bin/bash
#FLUX: --job-name=wobbly-leopard-1964
#FLUX: --urgency=16

mpirun --mca btl_tcp_if_exclude docker0,lo -np 5 jacobi-np4-4096 -- 4096 10000
