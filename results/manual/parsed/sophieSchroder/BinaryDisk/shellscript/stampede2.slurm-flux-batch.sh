#!/bin/bash
#FLUX: --job-name=arid-kerfuffle-2380
#FLUX: --urgency=16

module purge
module load intel
module load impi
module load phdf5
ibrun ./code/bin/athena -i athinput.binarydisk_stream
