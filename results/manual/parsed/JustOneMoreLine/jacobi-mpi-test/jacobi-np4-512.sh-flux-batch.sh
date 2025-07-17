#!/bin/bash
#FLUX: --job-name=goodbye-cherry-4477
#FLUX: --queue=batch
#FLUX: --urgency=16

mpirun --mca btl_tcp_if_exclude docker0,lo -np 4 jacobi-np4-512 -- 512 10000
