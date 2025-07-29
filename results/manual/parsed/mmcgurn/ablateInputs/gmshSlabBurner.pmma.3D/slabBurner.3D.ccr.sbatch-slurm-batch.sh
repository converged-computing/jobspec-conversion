#!/bin/bash
#FLUX: --job-name=sbLite
#FLUX: -N=200
#FLUX: --exclusive
#FLUX: -t=259200
#FLUX: --urgency=16

export PETSC_DIR='/projects/academic/chrest/owenmylo/petsc  '
export PETSC_ARCH='arch-ablate-opt'
export PKG_CONFIG_PATH='${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH'
export I_MPI_PMI_LIBRARY='/usr/lib64/libpmi.so'
export TEST_MPI_COMMAND='srun'
export DM_REFINE='1'
export TITLE='lowG-gMsh-dm$DM_REFINE-pmma-$SLURM_JOBID'
export FILE='/panasas/scratch/grp-chrest/owenmylo/ablateInputs/gmshSlabBurner.pmma.3D/slabBurner3D.lowG.3_8_23.yaml'

echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory = "$SLURM_SUBMIT_DIR
module load intel/20.2
module load intel-mpi/2020.2
module load gcc/11.2.0
module load cmake/3.22.3
module load valgrind/3.14.0
module load gdb/7.8
export PETSC_DIR=/projects/academic/chrest/owenmylo/petsc  
export PETSC_ARCH=arch-ablate-opt
export PKG_CONFIG_PATH="${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH"
NPROCS=`srun --nodes=${SLURM_NNODES} bash -c 'hostname' |wc -l`
echo NPROCS=$NPROCS
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so
export TEST_MPI_COMMAND=srun
mkdir tmp_$SLURM_JOBID
cd tmp_$SLURM_JOBID
export DM_REFINE=1
export TITLE=lowG-gMsh-dm$DM_REFINE-pmma-$SLURM_JOBID
export FILE=/panasas/scratch/grp-chrest/owenmylo/ablateInputs/gmshSlabBurner.pmma.3D/slabBurner3D.lowG.3_8_23.yaml
srun -n $SLURM_NPROCS  /projects/academic/chrest/owenmylo/ablateOpt/ablate \
  --input $FILE \
   -yaml::environment::title $TITLE \
   -yaml::timestepper::domain::faces [$FACES]
