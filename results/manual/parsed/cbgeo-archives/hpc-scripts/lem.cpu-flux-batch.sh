#!/bin/bash
#FLUX: --job-name=frigid-poodle-7520
#FLUX: -n=16
#FLUX: -t=126000
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export I_MPI_PIN_DOMAIN='omp:compact # Domains are $OMP_NUM_THREADS cores in size'
export I_MPI_PIN_ORDER='scatter # Adjacent domains have minimal sharing of caches/sockets'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load default-impi                   # REQUIRED - loads the basic environment
module load intel/tbb/4.4.2
module load intel/cmkl/11.3.3.210
module load cuda/8.0
. /scratch/cb-geo/spack/share/spack/setup-env.sh
spack load lem-develop
application="lem"
options="-d 3 -f /scratch/cb-geo/lem/benchmarks/fracture_200/ -s CG_MKL"
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
export OMP_NUM_THREADS=1
np=$[${numnodes}*${mpi_tasks_per_node}]
export I_MPI_PIN_DOMAIN=omp:compact # Domains are $OMP_NUM_THREADS cores in size
export I_MPI_PIN_ORDER=scatter # Adjacent domains have minimal sharing of caches/sockets
CMD="$application $options"
cd $workdir
echo -e "Changed directory to `pwd`.\n"
JOBID=$SLURM_JOB_ID
echo -e "JobID: $JOBID\n======"
echo "Time: `date`"
echo "Running on master node: `hostname`"
echo "Current directory: `pwd`"
if [ "$SLURM_JOB_NODELIST" ]; then
        #! Create a machine file:
        export NODEFILE=`generate_pbs_nodefile`
        cat $NODEFILE | uniq > machine.file.$JOBID
        echo -e "\nNodes allocated:\n================"
        echo `cat machine.file.$JOBID | sed -e 's/\..*$//g'`
fi
echo -e "\nnumtasks=$numtasks, numnodes=$numnodes, mpi_tasks_per_node=$mpi_tasks_per_node (OMP_NUM_THREADS=$OMP_NUM_THREADS)"
echo -e "\nExecuting command:\n==================\n$CMD\n"
eval $CMD 
