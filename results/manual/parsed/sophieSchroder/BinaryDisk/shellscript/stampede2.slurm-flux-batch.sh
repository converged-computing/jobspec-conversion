#!/bin/bash
#FLUX: --job-name=gassy-kitty-8375
#FLUX: --priority=16

module purge
module load intel
module load impi
module load phdf5
ibrun ./code/bin/athena -i athinput.binarydisk_stream
