#!/bin/bash
#FLUX: --job-name="slbBurn"
#FLUX: -N=8
#FLUX: --exclusive
#FLUX: --queue=scavenger
#FLUX: -t=259200
#FLUX: --priority=16

export PETSC_DIR='/projects/academic/chrest/mtmcgurn/petsc  '
export PETSC_ARCH='arch-ablate-opt'
export PKG_CONFIG_PATH='${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH'
export I_MPI_PMI_LIBRARY='/usr/lib64/libpmi.so'
export TEST_MPI_COMMAND='srun'
export TITLE='22G-448-rf15-physics-$SLURM_JOBID'
export VELOCITY='min(14.96274499,t*14.96274499/.01),0.0,0.0'

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
export PETSC_DIR=/projects/academic/chrest/mtmcgurn/petsc  
export PETSC_ARCH=arch-ablate-opt
export PKG_CONFIG_PATH="${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH"
NPROCS=`srun --nodes=${SLURM_NNODES} bash -c 'hostname' |wc -l`
echo NPROCS=$NPROCS
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so
export TEST_MPI_COMMAND=srun
mkdir tmp_$SLURM_JOBID
cd tmp_$SLURM_JOBID
export TITLE=22G-448-rf15-physics-$SLURM_JOBID
export VELOCITY="min(14.96274499,t*14.96274499/.01),0.0,0.0"
srun -n 448 \
 	/projects/academic/chrest/mtmcgurn/ablateOpt/ablate \
 	-yaml::timestepper::domain::faces [280,40,40] \
	--input /panasas/scratch/grp-chrest/mtmcgurn/ablateInputs/slabBurner3D/slabBurner.3D.physics.yaml \
	-yaml::environment::title $TITLE \
    -yaml::solvers::[1]::processes::[0]::velocity \"$VELOCITY\" \
    -yaml::timestepper::io::interval 250
