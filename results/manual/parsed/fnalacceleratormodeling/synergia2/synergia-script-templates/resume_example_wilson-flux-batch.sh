#!/bin/bash
#FLUX: --job-name=blank-destiny-1969
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export SYNERGIA2DIR='@@synergia2dir@@'
export PATH='${MPI_HOME}/bin:$PATH'
export LD_LIBRARY_PATH='${MPI_HOME}/lib:$LD_LIBRARY_PATH'
export HDF5_DISABLE_VERSION_CHECK='2'
export OMPI_MCA_mpi_warn_on_fork='0'

__queue{{#SBATCH -p @@queue@@}}{{}}__
__walltime{{#SBATCH -t @@walltime@@}}{{}}__
__account{{#SBATCH -A @@account@@}}{{}}__
export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
export SYNERGIA2DIR=@@synergia2dir@@
MPI_HOME=/usr/local/openmpi-3.0.1
export PATH=${MPI_HOME}/bin:$PATH
export LD_LIBRARY_PATH=${MPI_HOME}/lib:$LD_LIBRARY_PATH
export HDF5_DISABLE_VERSION_CHECK=2
. @@setupsh@@
echo "Job nodes: " $SLURM_JOB_NODELIST
if [ "$SLURM_JOB_PARTITION" == "intel12" ]
then
    cores_per_box=12
elif [ "$SLURM_JOB_PARTITION" == "amd32" ]
then
    cores_per_box=32
fi
cores_per_mpi=$(( @@numnode@@ * $cores_per_box/@@numproc@@ ))
echo "Job start at `date`"
export OMPI_MCA_mpi_warn_on_fork=0
srun --ntasks=@@numproc@@ --ntasks-per-node=@@procspernode@@ --mpi=pmi2 --cpu_bind=cores @@synergia_resume_executable@@
echo "Job end at `date`"
