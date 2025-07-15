#!/bin/bash
#FLUX: --job-name=purple-fudge-0656
#FLUX: --priority=16

module purge
module load intel/2019a GPAW ASE
mpirun gpaw-python ga.py
