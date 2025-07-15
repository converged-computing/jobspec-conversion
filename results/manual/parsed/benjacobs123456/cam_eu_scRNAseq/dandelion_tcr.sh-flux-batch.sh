#!/bin/bash
#FLUX: --job-name=crusty-snack-3741
#FLUX: -c=64
#FLUX: -t=28800
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
echo "Running singularity dandelion for TCRs"
cd /rds/user/hpcjaco1/hpc-work/Cambridge_EU_combined/dandelion_inputs/TCR/
for i in {1..214};
  do
    echo Doing donor $i of 214
    # filter meta file to just this person
    module load R/4.1.0-icelake
    Rscript /rds/project/sjs1016/rds-sjs1016-msgen/bj_scrna/scripts/joint_eu_cam/dandelion_bcr_filter_to_donor.R $i &
  done
wait
for i in {1..214};
  do
    echo Doing donor $i of 214
    # filter meta file to just this person
    module load R/4.1.0-icelake
    Rscript /rds/project/sjs1016/rds-sjs1016-msgen/bj_scrna/scripts/joint_eu_cam/dandelion_bcr_filter_to_donor.R $i
    # run dandelion
    META_FILE=meta_file_donor_$i
    singularity run -B $PWD --env R_LIBS_USER=~/dummy/:$R_LIBS_USER \
    ~/dandelion_jan23/sc-dandelion.sif dandelion-preprocess \
    --file_prefix "filtered" \
    --flavour "original" \
    --filter_to_high_confidence \
    --keep_trailing_hyphen_number \
    --meta $META_FILE \
    --chain TR &
  done
wait
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
