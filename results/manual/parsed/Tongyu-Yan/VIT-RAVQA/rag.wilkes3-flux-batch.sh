#!/bin/bash
#FLUX: --job-name=astute-hippo-1353
#FLUX: -t=43200
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel8/default-amp              # REQUIRED - loads the basic environment
source /usr/local/software/archive/linux-scientific7-x86_64/gcc-9/miniconda3-4.7.12.1-rmuek6r3f6p3v6fdj7o2klyzta3qhslh/bin/activate /home/ty308/.conda/envs/RAVQA2
export OMP_NUM_THREADS=1
JOBID=$SLURM_JOB_ID
LOG="/home/ty308/rds/hpc-work/myvqa/logs/logfile.$JOBID.log"
ERR="/home/ty308/rds/hpc-work/myvqa/logs/to/errorfile.$JOBID.err"
application="python src/main.py configs/okvqa/RAVQA.jsonnet"
options="--mode train  \
    --experiment_name V_RAG \
    --accelerator auto --devices 1  \
    --modules force_existence  \
    --opts train.epochs=5  \
            train.batch_size=1  \
            valid.step_size=1  \
            valid.batch_size=4  \
            train.additional.gradient_accumulation_steps=32  \
            train.lr=0.00006  \
            train.retriever_lr=0.00001  \
            train.scheduler=linear  \
            model_config.loss_ratio.additional_loss=1  \
            model_config.RAVQA_loss_type=Approach6  \
            data_loader.additional.num_knowledge_passages=5"
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
np=$[${numnodes}*${mpi_tasks_per_node}]
CMD="$application $options"
cd $workdir
echo -e "Changed directory to `pwd`.\n"
JOBID=$SLURM_JOB_ID
echo -e "JobID: $JOBID\n======" > $LOG
echo "Time: `date`" >> $LOG
echo "Running on master node: `hostname`" >> $LOG
echo "Current directory: `pwd`"
echo "Time: `date`" >> $LOG
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
