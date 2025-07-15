#!/bin/bash
#FLUX: --job-name=mpi
#FLUX: -n=2
#FLUX: -t=1200
#FLUX: --priority=16

export SINGULARITY_BINDPATH='/opt/mpich/mpich-3.1.4/apps'
export SINGULARITYENV_LD_LIBRARY_PATH='/opt/mpich/mpich-3.1.4/apps/lib'

export SINGULARITY_BINDPATH="/opt/mpich/mpich-3.1.4/apps"
export SINGULARITYENV_LD_LIBRARY_PATH="/opt/mpich/mpich-3.1.4/apps/lib"
srun -n 1 \
  singularity exec $SIFPATH/openfoam_v1812.sif \
  blockMesh | tee log.blockMesh
srun -n 1 \
  singularity exec $SIFPATH/openfoam_v1812.sif \
  topoSet | tee log.topoSet
srun -n 1 \
  singularity exec $SIFPATH/openfoam_v1812.sif \
  decomposePar -fileHandler uncollated | tee log.decomposePar
srun -n $SLURM_NTASKS \
  singularity exec $SIFPATH/openfoam_v1812.sif \
  simpleFoam -fileHandler uncollated -parallel | tee log.simpleFoam
srun -n 1 \
  singularity exec $SIFPATH/openfoam_v1812.sif \
  reconstructPar -latestTime -fileHandler uncollated | tee log.reconstructPar
