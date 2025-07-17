#!/bin/bash
#FLUX: --job-name=gMshNoSoot
#FLUX: -N=256
#FLUX: --queue=pbatch
#FLUX: -t=86400
#FLUX: --urgency=16

export PETSC_DIR='/usr/workspace/mcgurn4/petsc'
export PETSC_ARCH='arch-ablate-opt" # arch-ablate-debug or arch-ablate-opt'
export PKG_CONFIG_PATH='${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH'
export HDF5_ROOT='${PETSC_DIR}/${PETSC_ARCH}"  '
export PATH='${PETSC_DIR}/${PETSC_ARCH}/bin:$PATH'
export DM_REFINE='1'
export TITLE='lowG-gMsh-256n-dm$DM_REFINE-pmma-$SLURM_JOBID'
export FILE='/p/lustre2/ubchrest/ablateInputs/gmshSlabBurner.pmma.noSoot.3D/slabBurner3D.noSoot.lowG.3_8_23.yaml'

module load clang/14.0.6-magic
module load cmake/3.25.2
export PETSC_DIR="/usr/workspace/mcgurn4/petsc"
export PETSC_ARCH="arch-ablate-opt" # arch-ablate-debug or arch-ablate-opt
export PKG_CONFIG_PATH="${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH"
export HDF5_ROOT="${PETSC_DIR}/${PETSC_ARCH}"  
export PATH="${PETSC_DIR}/${PETSC_ARCH}/bin:$PATH"
mkdir tmp_$SLURM_JOBID
cd tmp_$SLURM_JOBID
export DM_REFINE=1
export TITLE=lowG-gMsh-256n-dm$DM_REFINE-pmma-$SLURM_JOBID
export FILE=/p/lustre2/ubchrest/ablateInputs/gmshSlabBurner.pmma.noSoot.3D/slabBurner3D.noSoot.lowG.3_8_23.yaml
spindle --location=/var/tmp/mcgurn4 srun -n9216 /usr/workspace/mcgurn4/ablateOpt/ablate \
   --input $FILE \
   -yaml::environment::title $TITLE \
   -yaml::timestepper::domain::options::dm_refine $DM_REFINE -build_twosided redscatter
echo 'Done'
