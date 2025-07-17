#!/bin/bash
#FLUX: --job-name=namd_job
#FLUX: -N=8
#FLUX: -n=196
#FLUX: --queue=normal
#FLUX: -t=108000
#FLUX: --urgency=16

module load namd/2.10
ibrun namd2 namd.in > namd.out
