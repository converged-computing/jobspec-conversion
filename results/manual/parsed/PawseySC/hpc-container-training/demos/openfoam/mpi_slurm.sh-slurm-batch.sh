#!/bin/bash
#SBATCH --job-name=mpi
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --constraint=ntasks-per-node=2

image="docker://quay.io/pawsey/openfoamlibrary:v2012"
module load singularity
srun -n 1 \
  singularity exec $image \
  blockMesh | tee log.blockMesh
srun -n 1 \
  singularity exec $image \
  topoSet | tee log.topoSet
srun -n 1 \
  singularity exec $image \
  decomposePar -fileHandler uncollated | tee log.decomposePar
srun -n $SLURM_NTASKS \
  singularity exec $image \
  simpleFoam -fileHandler uncollated -parallel | tee log.simpleFoam
srun -n 1 \
  singularity exec $image \
  reconstructPar -latestTime -fileHandler uncollated | tee log.reconstructPar
