#!/bin/bash
#FLUX: --job-name=hanky-carrot-0687
#FLUX: --exclusive
#FLUX: --queue=interactive
#FLUX: -t=60
#FLUX: --priority=16

module load OpenMPI
hpcstruct amg2006 
srun -n 4 hpcprof-mpi -S amg2006.hpcstruct hpctoolkit-all-measurements
