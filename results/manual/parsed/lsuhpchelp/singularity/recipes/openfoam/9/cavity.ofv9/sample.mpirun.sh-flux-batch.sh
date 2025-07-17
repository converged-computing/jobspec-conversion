#!/bin/bash
#FLUX: --job-name=crusty-plant-4523
#FLUX: -N=2
#FLUX: -n=128
#FLUX: --queue=checkpt
#FLUX: -t=300
#FLUX: --urgency=16

module purge
IMG="/home/admin/singularity/openfoam9.sdfibm-openmpi.4.0.3-pmi2.sif"
singularity exec -B /work ${IMG} blockMesh
singularity exec -B /work ${IMG} decomposePar -force
module load openmpi/4.1.3/intel-2021.5.0
SECONDS=0
mpirun -n 4 -npernode 2 singularity exec --pwd $PWD --bind /work ${IMG} icoFoam -parallel
echo "mpirun took $SECONDS sec."
