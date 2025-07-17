#!/bin/bash
#FLUX: --job-name=gasnet-mxm
#FLUX: -N=2
#FLUX: -n=2
#FLUX: --queue=tesla
#FLUX: -t=120
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export I_MPI_PIN_DOMAIN='omp:compact # Domains are $OMP_NUM_THREADS cores in size'
export I_MPI_PIN_ORDER='scatter # Adjacent domains have minimal sharing of caches/sockets'
export GASNET_IBV_SPAWNER='mpi'
export GASNET_SPAWNER='mpi'
export GASNET_CONDUIT='ibv'
export I_MPI_PMI_LIBRARY='/usr/local/Cluster-Apps/slurm/lib/libpmi.so'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
echo $mpi_tasks_per_node
application="/home/mf582/GASNet-1.26.0/mxm-conduit/testam"
options="5 10240"
options=""
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
export OMP_NUM_THREADS=1
np=$[${numnodes}*${mpi_tasks_per_node}]
export I_MPI_PIN_DOMAIN=omp:compact # Domains are $OMP_NUM_THREADS cores in size
export I_MPI_PIN_ORDER=scatter # Adjacent domains have minimal sharing of caches/sockets
export GASNET_IBV_SPAWNER=mpi
export GASNET_SPAWNER=mpi
export GASNET_CONDUIT=ibv
export I_MPI_PMI_LIBRARY=/usr/local/Cluster-Apps/slurm/lib/libpmi.so
CMD="srun -n $np ./regent.py examples/circuit.rg"
cd $workdir
echo -e "Changed directory to `pwd`.\n"
JOBID=$SLURM_JOB_ID
echo -e "JobID: $JOBID\n======"
echo "Time: `date`"
echo "Running on master node: `hostname`"
echo "Current directory: `pwd`"
echo -e "\nnumtasks=$numtasks, numnodes=$numnodes, mpi_tasks_per_node=$mpi_tasks_per_node (OMP_NUM_THREADS=$OMP_NUM_THREADS)"
echo -e "\nExecuting command:\n==================\n$CMD\n"
eval $CMD 
