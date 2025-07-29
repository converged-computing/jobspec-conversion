#!/bin/bash
#SBATCH --account=hpc_hpcadmin9
#SBATCH --output=output.mpirun
#SBATCH --nodes=2
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00

module purge
IMG="/home/admin/singularity/openfoam9.sdfibm-openmpi.4.0.3-pmi2.sif"
singularity exec -B /work ${IMG} blockMesh
singularity exec -B /work ${IMG} decomposePar -force
module load openmpi/4.1.3/intel-2021.5.0
SECONDS=0
mpirun -n 4 -npernode 2 singularity exec --pwd $PWD --bind /work ${IMG} icoFoam -parallel
echo "mpirun took $SECONDS sec."
