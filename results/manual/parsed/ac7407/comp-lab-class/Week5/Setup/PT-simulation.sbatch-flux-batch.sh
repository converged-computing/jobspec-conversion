#!/bin/bash
#FLUX: --job-name=PT-simulation
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load gromacs/openmpi/intel/2018.3
mpirun -np 4 gmx_mpi mdrun -s adp -multidir T300/ T350 T400/ T450 -deffnm adp_exchange4temps -replex 50
