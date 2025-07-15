#!/bin/bash
#FLUX: --job-name=stanky-buttface-1058
#FLUX: --urgency=16

export PETSC_DIR='/usr/workspace/ajbecerr/petsc" #UPDATE to the real path of petsc'
export PETSC_ARCH='arch-ablate-opt'
export PKG_CONFIG_PATH='${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH'
export HDF5_ROOT='${PETSC_DIR}/${PETSC_ARCH}"  '
export PATH='${PETSC_DIR}/${PETSC_ARCH}/bin:$PATH'

module load python
cd ../../preprocessing/
python perturbMechs.py $1 $2
python perturbSlabs.py $1 $2
cd ../ablateInputs/slabs/
module purge
module load clang/14.0.6-magic
module load cmake/3.25.2
export PETSC_DIR="/usr/workspace/ajbecerr/petsc" #UPDATE to the real path of petsc
export PETSC_ARCH="arch-ablate-opt"
export PKG_CONFIG_PATH="${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH"
export HDF5_ROOT="${PETSC_DIR}/${PETSC_ARCH}"  
export PATH="${PETSC_DIR}/${PETSC_ARCH}/bin:$PATH"
srun -n36 /usr/workspace/ajbecerr/ablateOpt/ablate --input /p/lustre2/ubchrest/CMAME_Final/ablateInputs/slabs/slabBurner.2D.$1.$2.yaml
