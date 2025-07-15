#!/bin/bash
#FLUX: --job-name=pbmpiORG1
#FLUX: -n=61
#FLUX: --queue=long
#FLUX: -t=2160000
#FLUX: --priority=16

STR="$(ls *.phy -x1)"
module load phylobayesmpi
mpirun -n 61 pb_mpi -d "$STR" -cat -gtr -dc "$STR".pb
