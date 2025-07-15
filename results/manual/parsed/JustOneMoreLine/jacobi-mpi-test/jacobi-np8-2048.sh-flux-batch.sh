#!/bin/bash
#FLUX: --job-name=nerdy-lettuce-6836
#FLUX: --priority=16

mpirun --mca btl_tcp_if_exclude docker0,lo -np 8 jacobi-np8-2048 -- 2048 10000
