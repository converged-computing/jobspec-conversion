#!/bin/bash
#FLUX: --job-name=nerdy-animal-7395
#FLUX: -t=14400
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel8/default-amp              # REQUIRED - loads the basic environment
module load parallel
module load python/3.8 cuda/11.2 cudnn/8.1_cuda-11.2  
source /home/mojb2/GI-PVI/venv/bin/activate
application="python experiments/classification.py"
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
mkdir -p slurm_logs/
export OMP_NUM_THREADS=1
np=$[${numnodes}*${mpi_tasks_per_node}]
JOBID=$SLURM_JOB_ID
LOG=slurm_logs/train-log.$JOBID
ERR=slurm_logs/train-err.$JOBID
echo "Initialising..." > $LOG
cd $workdir
echo -e "Changed directory to `pwd`.\n" >> $LOG
echo -e "JobID: $JOBID\n======" >> $LOG
echo "Time: `date`" >> $LOG
echo "Running on master node: `hostname`" >> $LOG
echo "Current directory: `pwd`" >> $LOG
if [ "$SLURM_JOB_NODELIST" ]; then
        #! Create a machine file:
        export NODEFILE=`generate_pbs_nodefile`
        cat $NODEFILE | uniq > machine.file.$JOBID
        echo -e "\nNodes allocated:\n================" >> $LOG
        echo `cat machine.file.$JOBID | sed -e 's/\..*$//g'` >> $LOG
fi
echo -e "\nnumtasks=$numtasks, numnodes=$numnodes, mpi_tasks_per_node=$mpi_tasks_per_node (OMP_NUM_THREADS=$OMP_NUM_THREADS)" >> $LOG
echo -e "\nExecuting command:\n==================\n$CMD\n" >> $LOG
srun="srun -N1 -n1"
$srun $application --q GI -d A --prior neal --server SYNC --split A --lr 0.001 -l 10000 -g 10 --batch 256 --M=100 --damp=0.2 &
wait
echo "Time: `date`" >> $LOG
