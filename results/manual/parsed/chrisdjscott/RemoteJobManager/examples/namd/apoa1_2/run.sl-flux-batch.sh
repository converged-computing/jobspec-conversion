#!/bin/bash
#FLUX: --job-name=rjmnamd2
#FLUX: -n=8
#FLUX: -t=600
#FLUX: --urgency=16

ml purge
ml NAMD/2.12-gimkl-2017a-mpi
srun namd2 apoa1.namd
