#!/bin/bash
#FLUX: --job-name=hello-knife-7831
#FLUX: --urgency=16

export PETSC_DIR='/usr/workspace/mcgurn4/petsc'
export PETSC_ARCH='arch-ablate-opt" # arch-ablate-debug or arch-ablate-opt'
export PKG_CONFIG_PATH='${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH'
export HDF5_ROOT='${PETSC_DIR}/${PETSC_ARCH}"  '
export PATH='${PETSC_DIR}/${PETSC_ARCH}/bin:$PATH'
export DM_REFINE='0'
export TITLE='lowG-gMsh-64n-dm$DM_REFINE-HF-$SLURM_JOBID'
export FILE='/p/lustre2/ubchrest/ablateInputs/gmshSlabBurner.pmma.3D.initGen/slabBurner3D.lowG.3_8_23.HF.yaml'

module load clang/14.0.6-magic
module load cmake/3.25.2
export PETSC_DIR="/usr/workspace/mcgurn4/petsc"
export PETSC_ARCH="arch-ablate-opt" # arch-ablate-debug or arch-ablate-opt
export PKG_CONFIG_PATH="${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH"
export HDF5_ROOT="${PETSC_DIR}/${PETSC_ARCH}"  
export PATH="${PETSC_DIR}/${PETSC_ARCH}/bin:$PATH"
mkdir tmp_$SLURM_JOBID
cd tmp_$SLURM_JOBID
export DM_REFINE=0
export TITLE=lowG-gMsh-64n-dm$DM_REFINE-HF-$SLURM_JOBID
export FILE=/p/lustre2/ubchrest/ablateInputs/gmshSlabBurner.pmma.3D.initGen/slabBurner3D.lowG.3_8_23.HF.yaml
srun -n2304 /usr/workspace/mcgurn4/ablateOpt/ablate \
   --input $FILE \
   -yaml::environment::title $TITLE \
   -yaml::timestepper::domain::options::dm_refine $DM_REFINE -build_twosided redscatter
echo 'Done'
