#!/bin/bash
#FLUX: --job-name=slbBurn
#FLUX: --exclusive
#FLUX: -t=259200
#FLUX: --urgency=16

export PETSC_DIR='/projects/academic/chrest/mtmcgurn/petsc  '
export PETSC_ARCH='arch-ablate-opt'
export PKG_CONFIG_PATH='${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH'
export I_MPI_PMI_LIBRARY='/usr/lib64/libpmi.so'
export TEST_MPI_COMMAND='srun'
export TITLE='22G-280x40-adapt-rad-loss-physics-constrained-$SLURM_JOBID'
export FACES='280,40'
export VELOCITY='min(14.96274499,t*14.96274499/.001+1),0.0'
export FILE='/panasas/scratch/grp-chrest/mtmcgurn/ablateInputs/slabBurner2D/slabBurner.2D.physicsConstraint.radLoss.yaml'

echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory = "$SLURM_SUBMIT_DIR
module unload intel-mpi/2020.2
module load intel/20.2
module load intel-mpi/2020.2
module load gcc/11.2.0
module load cmake/3.22.3
module load valgrind/3.14.0
module load gdb/7.8
export PETSC_DIR=/projects/academic/chrest/mtmcgurn/petsc  
export PETSC_ARCH=arch-ablate-opt
export PKG_CONFIG_PATH="${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH"
NPROCS=`srun --nodes=${SLURM_NNODES} bash -c 'hostname' |wc -l`
echo NPROCS=$NPROCS
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so
export TEST_MPI_COMMAND=srun
mkdir tmp_$SLURM_JOBID
cd tmp_$SLURM_JOBID
export TITLE=6G-280x40-adapt-rad-loss-physics-constrained-$SLURM_JOBID
export FACES=280,40
export VELOCITY="min(3.985120454,t*3.985120454/.001+1),0.0"
export FILE=/panasas/scratch/grp-chrest/mtmcgurn/ablateInputs/slabBurner2D/slabBurner.2D.physicsConstraint.radLoss.yaml
export TITLE=22G-280x40-adapt-rad-loss-physics-constrained-$SLURM_JOBID
export FACES=280,40
export VELOCITY="min(14.96274499,t*14.96274499/.001+1),0.0"
export FILE=/panasas/scratch/grp-chrest/mtmcgurn/ablateInputs/slabBurner2D/slabBurner.2D.physicsConstraint.radLoss.yaml
srun -n $SLURM_NPROCS  /projects/academic/chrest/mtmcgurn/ablateOpt/ablate \
  --input $FILE \
   -yaml::environment::title $TITLE \
   -yaml::timestepper::domain::faces [$FACES] \
   -yaml::solvers::[1]::processes::[0]::velocity \"$VELOCITY\" 
