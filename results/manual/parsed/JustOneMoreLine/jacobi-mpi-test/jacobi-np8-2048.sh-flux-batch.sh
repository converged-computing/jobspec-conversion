#!/bin/bash
#FLUX: --job-name=pusheena-pancake-3964
#FLUX: --urgency=16

mpirun --mca btl_tcp_if_exclude docker0,lo -np 8 jacobi-np8-2048 -- 2048 10000
