#!/bin/bash
#FLUX: --job-name=jobname
#FLUX: --exclusive
#FLUX: -t=43200
#FLUX: --urgency=16

module load ORCA/5.0.2-gompi-2021b
module load OpenMPI/4.1.1-GCC-9.3.0-UCX-1.10.0-libfabric-1.12.1-PMIx-3.2.3
C:\Users\shaba\Documents\ORCA\ORCA_INP orca.inp > orca.out
