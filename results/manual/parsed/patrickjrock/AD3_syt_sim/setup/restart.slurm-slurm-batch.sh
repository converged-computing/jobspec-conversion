#!/bin/bash
#FLUX: --job-name=namd_job
#FLUX: -N=8
#FLUX: -n=196
#FLUX: --queue=normal
#FLUX: -t=172800
#FLUX: --urgency=16

module load namd/2.10
ibrun namd2 restart.namd > restart.out
