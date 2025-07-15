#!/bin/bash
#FLUX: --job-name=gassy-chair-8482
#FLUX: --urgency=16

export PETSC_DIR='/usr/workspace/mcgurn4/petsc'
export PETSC_ARCH='arch-ablate-opt-gcc" # arch-ablate-debug or arch-ablate-opt'
export PKG_CONFIG_PATH='${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH'
export HDF5_ROOT='${PETSC_DIR}/${PETSC_ARCH}"  '
export PATH='${PETSC_DIR}/${PETSC_ARCH}/bin:$PATH'
export FILE='/p/lustre2/ubchrest/ablateInputs/slabBurner.pmma.3D.scaling/slabBurner.3D.6G.pmma.rad.yaml'
export nodes='2304'

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
export FILE=/p/lustre2/ubchrest/ablateInputs/slabBurner.pmma.3D.scaling/slabBurner.3D.6G.pmma.rad.yaml
export nodes=2304
spindle --location=/var/tmp/mcgurn4 srun -n${nodes} /usr/workspace/mcgurn4/ablateOpt/ablate \
   --input $FILE \
   -yaml::environment::title dm0-${nodes}-$SLURM_JOBID \
   -yaml::timestepper::domain::faces [80,20,20] \
   -log_view :/p/lustre2/ubchrest/ablateInputs/slabBurner.pmma.3D.scaling/tmp_${SLURM_JOBID}/ConvEst_Refinement_Level_0_${nodes}.csv:ascii_csv  -build_twosided redscatter
spindle --location=/var/tmp/mcgurn4 srun -n${nodes} /usr/workspace/mcgurn4/ablateOpt/ablate \
   --input $FILE \
   -yaml::environment::title dm1-${nodes}-$SLURM_JOBID \
   -yaml::timestepper::domain::faces [80,20,20] \
   -log_view :/p/lustre2/ubchrest/ablateInputs/slabBurner.pmma.3D.scaling/tmp_${SLURM_JOBID}/ConvEst_Refinement_Level_1_${nodes}.csv:ascii_csv  -build_twosided redscatter
spindle --location=/var/tmp/mcgurn4 srun -n${nodes} /usr/workspace/mcgurn4/ablateOpt/ablate \
   --input $FILE \
   -yaml::environment::title dm2-${nodes}-$SLURM_JOBID \
   -yaml::timestepper::domain::faces [160,40,40] \
   -log_view :/p/lustre2/ubchrest/ablateInputs/slabBurner.pmma.3D.scaling/tmp_${SLURM_JOBID}/ConvEst_Refinement_Level_2_${nodes}.csv:ascii_csv  -build_twosided redscatter
spindle --location=/var/tmp/mcgurn4 srun -n${nodes} /usr/workspace/mcgurn4/ablateOpt/ablate \
   --input $FILE \
   -yaml::environment::title dm3-${nodes}-$SLURM_JOBID \
   -yaml::timestepper::domain::faces [320,80,80] \
   -log_view :/p/lustre2/ubchrest/ablateInputs/slabBurner.pmma.3D.scaling/tmp_${SLURM_JOBID}/ConvEst_Refinement_Level_3_${nodes}.csv:ascii_csv  -build_twosided redscatter
spindle --location=/var/tmp/mcgurn4 srun -n${nodes} /usr/workspace/mcgurn4/ablateOpt/ablate \
   --input $FILE \
   -yaml::environment::title dm4-${nodes}-$SLURM_JOBID \
   -yaml::timestepper::domain::faces [640,160,160] \
   -log_view :/p/lustre2/ubchrest/ablateInputs/slabBurner.pmma.3D.scaling/tmp_${SLURM_JOBID}/ConvEst_Refinement_Level_4_${nodes}.csv:ascii_csv  -build_twosided redscatter
echo 'Done'
