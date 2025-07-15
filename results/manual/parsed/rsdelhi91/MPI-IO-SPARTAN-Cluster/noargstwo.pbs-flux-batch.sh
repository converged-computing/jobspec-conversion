#!/bin/bash
#FLUX: --job-name="cloud"
#FLUX: -n=8
#FLUX: -t=3600
#FLUX: --priority=16

module load Python/3.4.3-goolf-2015a
mpirun -np 8 python mpigeneric.py
