#!/bin/bash
#FLUX: --job-name=Pump
#FLUX: -N=4
#FLUX: --queue=multiple
#FLUX: -t=172800
#FLUX: --urgency=16

export KMP_AFFINITY='compact,1,0'

export KMP_AFFINITY=compact,1,0
module load compiler/intel/19.1
module load mpi/openmpi/4.0
mpirun --bind-to core --map-by core singularity run --bind /pfs/work7/workspace/scratch/lr1762-flow/ --bind /scratch --bind /tmp --pwd=$PWD $HOME/programs/lammps.sif -i $(pwd)/flow.LAMMPS
