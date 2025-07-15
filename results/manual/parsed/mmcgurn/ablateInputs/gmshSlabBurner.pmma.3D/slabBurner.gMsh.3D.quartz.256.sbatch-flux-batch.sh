#!/bin/bash
#FLUX: --job-name=cowy-latke-3244
#FLUX: --priority=16

export PETSC_DIR='/usr/workspace/mcgurn4/petsc'
export PETSC_ARCH='arch-ablate-opt" # arch-ablate-debug or arch-ablate-opt'
export PKG_CONFIG_PATH='${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH'
export HDF5_ROOT='${PETSC_DIR}/${PETSC_ARCH}"  '
export PATH='${PETSC_DIR}/${PETSC_ARCH}/bin:$PATH'
export DM_REFINE='1'
export TITLE='lowG-gMsh-256n-dm$DM_REFINE-pmma-ls-$SLURM_JOBID'
export FILE='/p/lustre2/mcgurn4/ablateInputs/gmshSlabBurner.pmma.3D/slab_lowG_simpleBC.yaml'
export FIELD_TYPE='leastsquares'

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
export TITLE=lowG-gMsh-256n-dm$DM_REFINE-pmma-ls-$SLURM_JOBID
export FILE=/p/lustre2/mcgurn4/ablateInputs/gmshSlabBurner.pmma.3D/slab_lowG_simpleBC.yaml
export FIELD_TYPE=leastsquares
srun -n9216 /usr/workspace/mcgurn4/ablateOpt/ablate \
   --input $FILE \
   -yaml::environment::title $TITLE \
   -yaml::timestepper::domain::options::dm_refine $DM_REFINE -build_twosided redscatter \
   -yaml::timestepper::domain::fields::[0]::conservedFieldOptions::petscfv_type $FIELD_TYPE
echo 'Done'
