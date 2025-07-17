#!/bin/bash
#FLUX: --job-name=g11hllen
#FLUX: -N=8
#FLUX: -n=512
#FLUX: --queue=normal
#FLUX: -t=144000
#FLUX: --urgency=16

module purge
module load intel
module load impi
module load phdf5
ibrun ./code/bin/athena -i athinput.binarydisk_stream
