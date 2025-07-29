#!/bin/bash
#FLUX: --job-name=GA
#FLUX: --queue=hebbe
#FLUX: -t=36000
#FLUX: --urgency=16

module purge
module load intel/2019a GPAW ASE
mpirun gpaw-python ga.py
