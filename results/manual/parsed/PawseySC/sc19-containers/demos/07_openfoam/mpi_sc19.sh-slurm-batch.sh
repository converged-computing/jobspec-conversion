#!/bin/bash
#SBATCH --job-name=mpi
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --constraint=ntasks-per-node=2

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
