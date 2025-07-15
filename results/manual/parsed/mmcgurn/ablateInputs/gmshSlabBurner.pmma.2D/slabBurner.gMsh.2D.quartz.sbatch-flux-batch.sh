#!/bin/bash
#FLUX: --job-name=crusty-eagle-4427
#FLUX: --urgency=16

export PETSC_DIR='/p/lustre2/mcgurn4/petsc'
export PETSC_ARCH='arch-ablate-opt-gcc" # arch-ablate-debug or arch-ablate-opt'
export PKG_CONFIG_PATH='${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH'
export HDF5_ROOT='${PETSC_DIR}/${PETSC_ARCH}"  '
export PATH='${PETSC_DIR}/${PETSC_ARCH}/bin:$PATH'
export DM_REFINE='0'
export TITLE='lowG-gMsh-dm$DM_REFINE-pmma-$SLURM_JOBID'
export FILE='/p/lustre2/ubchrest/ablateInputs/gmshSlabBurner.pmma.2D/slabBurner2D.lowG.3_8_23.yaml'

module load mkl/2019.0
module load valgrind/3.16.1
module load gcc/10.2.1
module load cmake/3.21.1 
export PETSC_DIR="/p/lustre2/mcgurn4/petsc"
export PETSC_ARCH="arch-ablate-opt-gcc" # arch-ablate-debug or arch-ablate-opt
export PKG_CONFIG_PATH="${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH"
export HDF5_ROOT="${PETSC_DIR}/${PETSC_ARCH}"  
export PATH="${PETSC_DIR}/${PETSC_ARCH}/bin:$PATH"
mkdir tmp_$SLURM_JOBID
cd tmp_$SLURM_JOBID
export DM_REFINE=0
export TITLE=lowG-gMsh-dm$DM_REFINE-pmma-$SLURM_JOBID
export FILE=/p/lustre2/ubchrest/ablateInputs/gmshSlabBurner.pmma.2D/slabBurner2D.lowG.3_8_23.yaml
srun -n864
 /p/lustre2/mcgurn4/ablateOpt/ablate \
   --input $FILE \
   -yaml::environment::title $TITLE \
   -yaml::timestepper::domain::options::dm_refine $DM_REFINE
echo 'Done'
