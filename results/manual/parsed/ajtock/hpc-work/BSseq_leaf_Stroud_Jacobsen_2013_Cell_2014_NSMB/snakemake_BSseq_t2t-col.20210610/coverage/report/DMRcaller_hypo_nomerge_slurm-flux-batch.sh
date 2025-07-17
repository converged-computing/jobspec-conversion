#!/bin/bash
#FLUX: --job-name=DMRcaller
#FLUX: --queue=skylake
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
PARAMS=$(cat slurm_params/DMRcaller_hypo_nomerge_slurm_params.tsv | head -n ${SLURM_ARRAY_TASK_ID} | tail -n 1)                
CONDITION1=$(echo $PARAMS | cut -d ' ' -f 1)
CONDITION2=$(echo $PARAMS | cut -d ' ' -f 2)
REFBASE=$(echo $PARAMS | cut -d ' ' -f 3)
CHRNAME=$(echo $PARAMS | cut -d ' ' -f 4)
GENOMEREGION=$(echo $PARAMS | cut -d ' ' -f 5)
QUANTILES=$(echo $PARAMS | cut -d ' ' -f 6)
CONTEXT=$(echo $PARAMS | cut -d ' ' -f 7)
echo "Slurm array task ID: $SLURM_ARRAY_TASK_ID"
echo "Number of CPUs used: $SLURM_CPUS_PER_TASK"
echo "This job is running on:"
hostname
echo "condition1: $CONDITION1"
echo "condition2: $CONDITION2"
echo "refbase: $REFBASE"
echo "chrName: $CHRNAME"
echo "genomeRegion: $GENOMEREGION"
echo "quantiles: $QUANTILES"
echo "context: $CONTEXT"
source ~/.bashrc
conda activate python_3.9.6
echo $(which R)
application="DMRcaller_hypo_nomerge.R"
options="--condition1 $CONDITION1 \
         --condition2 $CONDITION2 \
         --refbase $REFBASE \
         --chrName $CHRNAME \
         --genomeRegion $GENOMEREGION \
         --quantiles $QUANTILES \
         --context $CONTEXT"
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
conda deactivate
