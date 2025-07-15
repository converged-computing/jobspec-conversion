#!/bin/bash
#FLUX: --job-name=nerdy-fudge-6170
#FLUX: --urgency=16

module purge
module load intel/2019a GPAW ASE
mpirun gpaw-python ga.py
