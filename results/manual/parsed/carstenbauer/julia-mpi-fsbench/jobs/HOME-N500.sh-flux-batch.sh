#!/bin/bash
#FLUX: --job-name=persnickety-chair-0390
#FLUX: -N=500
#FLUX: -n=32000
#FLUX: -c=2
#FLUX: --exclusive
#FLUX: --queue=cont
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export OMPI_MCA_hwloc_base_report_bindings='false'
export JULIA_DEPOT_PATH='/upb/departments/pc2/users/b/bauerc/.julia_fsbench'
export JULIA_MPI_BINARY='system'

export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
export OMPI_MCA_hwloc_base_report_bindings=false
export JULIA_DEPOT_PATH=/upb/departments/pc2/users/b/bauerc/.julia_fsbench
export JULIA_MPI_BINARY=system
cd /scratch/pc2-mitarbeiter/bauerc/devel/julia-mpi-fsbench/jobs
source ../.envrc
echo "starting N 500 trials"
echo "Julia depot located at $JULIA_DEPOT_PATH"
for i in {1..5}
do
   time srun --cpu_bind=cores julia --project ../bench.jl
   # time srun --cpu_bind=cores julia --project ../bench.jl verbose
   echo "N 500 trial $i completed"
   sleep 10
done
