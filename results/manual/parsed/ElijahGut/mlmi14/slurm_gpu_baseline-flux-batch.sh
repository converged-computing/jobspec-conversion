#!/bin/bash
#FLUX: --job-name=dinosaur-parsnip-7636
#FLUX: -t=3600
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

options=""
numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel8/default-amp              # REQUIRED - loads the basic environment
source /home/${USER}/.bashrc
source /rds/project/rds-xyBFuSj0hm0/MLMI2.M2022/miniconda3/bin/activate
application="python -u run.py \
                --train_json data/train.json \
                --val_json data/dev.json \
                --test_json data/test.json \
                --batch_size 4 \
                --lr 0.0001 \
                --vocab data/vocab.txt \
                --model wav2vec2 \
		--optimiser adam \
                --num_epochs 20"
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
export OMP_NUM_THREADS=1
np=$[${numnodes}*${mpi_tasks_per_node}]
cd $workdir
echo -e "Changed directory to `pwd`.\n"
mkdir -p logs
JOBID=$SLURM_JOB_ID
CMD="$application $options > logs/out.$JOBID"
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
