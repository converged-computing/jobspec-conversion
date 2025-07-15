#!/bin/bash
#FLUX: --job-name=swampy-banana-0641
#FLUX: -n=6
#FLUX: -t=900
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export I_MPI_PIN_DOMAIN='omp:compact # Domains are $OMP_NUM_THREADS cores in size'
export I_MPI_PIN_ORDER='compact #Required for speed.'
export CONTAINER='/home/dc-wils4/lfric/lfric_env.sif'
export BIND_OPT='-B /usr/local/Cluster-Apps'
export LOCAL_LD_LIBRARY_PATH='/usr/local/Cluster-Apps/intel/2017.4/compilers_and_libraries_2017.4.196/linux/mpi/intel64/lib'

module purge                               # Removes all modules still loaded
module load rhel7/default-peta4
module load singularity/current
export OMP_NUM_THREADS=1
export I_MPI_PIN_DOMAIN=omp:compact # Domains are $OMP_NUM_THREADS cores in size
export I_MPI_PIN_ORDER=compact #Required for speed.
cd /home/dc-wils4/lfric/trunk/gungho/example
export CONTAINER=/home/dc-wils4/lfric/lfric_env.sif
export BIND_OPT="-B /usr/local/Cluster-Apps"
export LOCAL_LD_LIBRARY_PATH="/usr/local/Cluster-Apps/intel/2017.4/compilers_and_libraries_2017.4.196/linux/mpi/intel64/lib"
mpirun -np 6 singularity exec $BIND_OPT $CONTAINER ../bin/gungho configuration.nml
