#!/bin/bash
#FLUX: --job-name=fat-butter-6530
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
module load rhel7/default-peta4            # REQUIRED - loads the basic environment
[ -d logs ] || mkdir -p logs
PARAMS=$(cat slurm_params/alphabeta_per_cytosine_per_genomeBin_MA1_2_CpG_slurm_params.tsv | head -n ${SLURM_ARRAY_TASK_ID} | tail -n 1)
REF_BASE="t2t-col.20210610"
CONTEXT="CpG"
BINSIZE="2000000"
STEPSIZE="200000"
CHR=$(echo $PARAMS | cut -d ' ' -f 1)
BINSTART=$(echo $PARAMS | cut -d ' ' -f 2)
BINEND=$(echo $PARAMS | cut -d ' ' -f 3)
echo "Slurm array task ID: $SLURM_ARRAY_TASK_ID"
echo "Number of CPUs used: $SLURM_CPUS_PER_TASK"
echo "This job is running on:"
hostname
echo "refbase: $REF_BASE"
echo "context: $CONTEXT"
echo "genomeBinSize: $BINSIZE"
echo "genomeStepSize: $STEPSIZE"
echo "chrName: $CHR"
echo "binStart: $BINSTART"
echo "binEnd: $BINEND"
application="./alphabeta_per_cytosine_per_genomeBin_MA1_2.R"
echo $(which R)
options="$REF_BASE $CONTEXT $BINSIZE $STEPSIZE $CHR $BINSTART $BINEND"
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
export OMP_NUM_THREADS=1
np=$[${numnodes}*${mpi_tasks_per_node}]
export I_MPI_PIN_DOMAIN=omp:compact # Domains are $OMP_NUM_THREADS cores in size
export I_MPI_PIN_ORDER=scatter # Adjacent domains have minimal sharing of caches/sockets
CMD="mpirun -ppn $mpi_tasks_per_node -np $np $application $options"
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
