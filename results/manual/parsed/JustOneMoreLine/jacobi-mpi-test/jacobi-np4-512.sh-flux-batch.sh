#!/bin/bash
#FLUX: --job-name=blank-punk-9986
#FLUX: --priority=16

mpirun --mca btl_tcp_if_exclude docker0,lo -np 4 jacobi-np4-512 -- 512 10000
