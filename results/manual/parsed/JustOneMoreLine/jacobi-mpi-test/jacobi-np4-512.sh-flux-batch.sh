#!/bin/bash
#FLUX: --job-name=wobbly-gato-0921
#FLUX: --urgency=16

mpirun --mca btl_tcp_if_exclude docker0,lo -np 4 jacobi-np4-512 -- 512 10000
