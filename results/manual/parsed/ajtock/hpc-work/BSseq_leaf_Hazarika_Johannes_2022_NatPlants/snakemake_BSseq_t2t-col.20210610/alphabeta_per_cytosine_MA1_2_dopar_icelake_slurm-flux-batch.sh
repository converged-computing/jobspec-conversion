#!/bin/bash
#FLUX: --job-name=muffled-pedo-7740
#FLUX: -N=6
#FLUX: -n=444
#FLUX: -t=43200
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export I_MPI_PIN_DOMAIN='omp:compact # Domains are $OMP_NUM_THREADS cores in size'
export I_MPI_PIN_ORDER='scatter # Adjacent domains have minimal sharing of caches/sockets'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel8/default-icl              # REQUIRED - loads the basic environment
PARAMS=$(cat slurm_params/alphabeta_per_cytosine_MA1_2_dopar_slurm_params.tsv | head -n 1 | tail -n 1)
REFBASE=$(echo $PARAMS | cut -d ' ' -f 1)
CONTEXT=$(echo $PARAMS | cut -d ' ' -f 2)
BINSIZE=$(echo $PARAMS | cut -d ' ' -f 3)
STEPSIZE=$(echo $PARAMS | cut -d ' ' -f 4)
CHR=$(echo $PARAMS | cut -d ' ' -f 5)
CORES=$(( $numtasks - 1 )) 
source ~/.bashrc
conda activate R-4.1.2
echo $(which R)
echo "Number of nodes used: $numnodes"
echo "Number of tasks: $numtasks"
echo "Number of tasks per node: $mpi_tasks_per_node" 
echo "This job is running on:"
hostname
application="./alphabeta_per_cytosine_MA1_2_dopar.R"
options="$REFBASE $CONTEXT $BINSIZE $STEPSIZE $CHR $CORES"
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
export OMP_NUM_THREADS=1
np=$[${numnodes}*${mpi_tasks_per_node}]
export I_MPI_PIN_DOMAIN=omp:compact # Domains are $OMP_NUM_THREADS cores in size
export I_MPI_PIN_ORDER=scatter # Adjacent domains have minimal sharing of caches/sockets
CMD="mpirun -npernode $mpi_tasks_per_node $application $options"
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
conda deactivate
