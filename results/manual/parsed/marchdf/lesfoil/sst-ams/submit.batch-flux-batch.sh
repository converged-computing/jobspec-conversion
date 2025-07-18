#!/bin/bash
#FLUX: --job-name=lesfoil
#FLUX: --queue=debug
#FLUX: -t=600
#FLUX: --urgency=16

export SPACK_MANAGER='${HOME}/exawind/spack-manager'
export OMP_NUM_THREADS='1  # Max hardware threads = 4'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

module purge
export SPACK_MANAGER=${HOME}/exawind/spack-manager
source ${SPACK_MANAGER}/start.sh && quick-activate ${SPACK_MANAGER}/environments/nalu-wind-dev
spack load nalu-wind
ranks_per_node=36
mpi_ranks=$(expr $SLURM_JOB_NUM_NODES \* $ranks_per_node)
export OMP_NUM_THREADS=1  # Max hardware threads = 4
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
nalu_exec="$(spack location -i nalu-wind)/bin/naluX"
echo "Job name       = $SLURM_JOB_NAME"
echo "Num. nodes     = $SLURM_JOB_NUM_NODES"
echo "Num. MPI Ranks = $mpi_ranks"
echo "Num. threads   = $OMP_NUM_THREADS"
echo "Working dir    = $PWD"
srun -n ${mpi_ranks} -c 1 ${nalu_exec} -i lesfoil.yaml -o lesfoil.log
