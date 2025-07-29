#!/bin/bash
#FLUX: --job-name=6G
#FLUX: -N=128
#FLUX: --queue=pbatch
#FLUX: -t=86400
#FLUX: --urgency=16

export PETSC_DIR='/usr/workspace/mcgurn4/petsc'
export PETSC_ARCH='arch-ablate-opt-gcc" # arch-ablate-debug or arch-ablate-opt'
export PKG_CONFIG_PATH='${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH'
export HDF5_ROOT='${PETSC_DIR}/${PETSC_ARCH}"  '
export PATH='${PETSC_DIR}/${PETSC_ARCH}/bin:$PATH'
export TITLE='6G-186x40x40-pmma-rad-noSoot-$SLURM_JOBID'
export FACES='186,40,40'
export FILE='/p/lustre2/ubchrest/ablateInputs/slabBurner.pmma.3D/slabBurner.3D.6G.pmma.rad.yaml'

module load mkl/2019.0
module load valgrind/3.16.1
module load gcc/10.2.1
module load cmake/3.21.1 
export PETSC_DIR="/usr/workspace/mcgurn4/petsc"
export PETSC_ARCH="arch-ablate-opt-gcc" # arch-ablate-debug or arch-ablate-opt
export PKG_CONFIG_PATH="${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH"
export HDF5_ROOT="${PETSC_DIR}/${PETSC_ARCH}"  
export PATH="${PETSC_DIR}/${PETSC_ARCH}/bin:$PATH"
mkdir tmp_$SLURM_JOBID
cd tmp_$SLURM_JOBID
export TITLE=6G-186x40x40-pmma-rad-noSoot-$SLURM_JOBID
export FACES=186,40,40
export FILE=/p/lustre2/ubchrest/ablateInputs/slabBurner.pmma.3D/slabBurner.3D.6G.pmma.rad.yaml
spindle --location=/var/tmp/mcgurn4 srun -n4608 /usr/workspace/mcgurn4/ablateOpt/ablate \
   --input $FILE \
   -yaml::environment::title $TITLE \
   -yaml::timestepper::domain::faces [$FACES]
echo 'Done'
