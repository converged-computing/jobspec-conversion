#!/bin/bash
#FLUX: --job-name=amr_alm
#FLUX: -N=114
#FLUX: -t=54900
#FLUX: --priority=16

export SPACK_MANAGER='${HOME}/exawind/spack-manager'
export OMP_NUM_THREADS='1  # Max hardware threads = 4'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

module purge
module load mpt
export SPACK_MANAGER=${HOME}/exawind/spack-manager
source ${SPACK_MANAGER}/start.sh && quick-activate ${SPACK_MANAGER}/environments/amr-wind-alm-34
spack load amr-wind
ranks_per_node=36
mpi_ranks=$(expr $SLURM_JOB_NUM_NODES \* $ranks_per_node)
export OMP_NUM_THREADS=1  # Max hardware threads = 4
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
aw_exec="$(spack location -i amr-wind)/bin/amr_wind"
echo "Job name       = $SLURM_JOB_NAME"
echo "Num. nodes     = $SLURM_JOB_NUM_NODES"
echo "Num. MPI Ranks = $mpi_ranks"
echo "Num. threads   = $OMP_NUM_THREADS"
echo "Working dir    = $PWD"
cp ${aw_exec} $(pwd)/amr_wind
srun -n ${mpi_ranks} -c 1 --cpu_bind=cores $(pwd)/amr_wind alm.inp > out.log 2>&1
