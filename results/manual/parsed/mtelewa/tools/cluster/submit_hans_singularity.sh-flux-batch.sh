#!/bin/bash
#FLUX: --job-name=hans
#FLUX: --queue=single
#FLUX: -t=14400
#FLUX: --urgency=16

export KMP_AFFINITY='compact,1,0'

export KMP_AFFINITY=compact,1,0
module load compiler/intel/19.1
module load mpi/openmpi/4.0
mpirun --bind-to core --map-by core singularity exec --bind /scratch --bind /tmp --bind /pfs/work7/workspace/scratch/lr1762-flow --pwd=$PWD $HOME/programs/hans.sif python3 -m hans -i $(pwd)/channel1D_DH.yaml
