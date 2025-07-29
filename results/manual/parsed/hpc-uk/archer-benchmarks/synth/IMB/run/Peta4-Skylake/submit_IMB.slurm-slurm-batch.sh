#!/bin/bash
#FLUX: --job-name=gmx_bench
#FLUX: -N=4
#FLUX: -n=128
#FLUX: --queue=skylake
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export I_MPI_PIN_DOMAIN='omp:compact # Domains are $OMP_NUM_THREADS cores in size'
export I_MPI_PIN_ORDER='scatter # Adjacent domains have minimal sharing of caches/sockets'
export IMBDIR='/home/hpcturn1/rds/hpc-work/benchmarks/mpi-benchmarks'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module add dot slurm turbovnc vgl singularity 
module add rhel7/global 
module add intel/bundles/complib/2019.3
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
export OMP_NUM_THREADS=1
np=$[${numnodes}*${mpi_tasks_per_node}]
export I_MPI_PIN_DOMAIN=omp:compact # Domains are $OMP_NUM_THREADS cores in size
export I_MPI_PIN_ORDER=scatter # Adjacent domains have minimal sharing of caches/sockets
cat $0
export IMBDIR="/home/hpcturn1/rds/hpc-work/benchmarks/mpi-benchmarks"
nodes=4
cpn=32
tests="PingPong Sendrecv Allgather Alltoall Allgatherv Alltoallv"
mpilib="IMPI193"
timestamp=$(date '+%Y%m%d%H%M')
cores=$(( nodes * cpn ))
for test in $tests
do
   mpirun -n $cores -ppn ${cpn} ${IMBDIR}/IMB-MPI1 -mem 1.4 -npmin ${cores} ${test} > IMB_${test}_${nodes}nodes_${mpilib}_${timestamp}.out
done
