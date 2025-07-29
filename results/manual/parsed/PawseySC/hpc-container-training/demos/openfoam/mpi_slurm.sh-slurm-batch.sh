#!/bin/bash
#FLUX: --job-name=mpi
#FLUX: -n=2
#FLUX: -t=1200
#FLUX: --urgency=16

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
