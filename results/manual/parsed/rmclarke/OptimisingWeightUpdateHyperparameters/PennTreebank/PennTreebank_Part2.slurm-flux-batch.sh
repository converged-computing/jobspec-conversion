#!/bin/bash
#FLUX: --job-name=PTB-2
#FLUX: -c=32
#FLUX: --queue=ampere
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel8/default-amp              # REQUIRED - loads the basic environment
module load python/3.7
module load cuda/11.1
module load cudnn/8.0_cuda-11.1
if [ ${subconfig} == "Random_SteppedLR" ]; then
    init_path="/home/rmc78/ShortHorizonBias/PennTreebank/inits_scheduled_lr/iteration_${SLURM_ARRAY_TASK_ID}.yaml"
else
    init_path="/home/rmc78/ShortHorizonBias/PennTreebank/inits/iteration_${SLURM_ARRAY_TASK_ID}.yaml"
fi
load_path="/home/rmc78/ShortHorizonBias/PennTreebank/checkpoints/iteration_${SLURM_ARRAY_TASK_ID}.pt"
application="source .venv-slurm/bin/activate && python"
options="train.py -c ./configs/${subconfig}.yaml ./configs/penn_treebank.yaml ${init_path} -n "Iteration_${SLURM_ARRAY_TASK_ID}" -g ${subconfig} -l "${write_path}_Part2/" -s ${load_path}"
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
export OMP_NUM_THREADS=1
np=$[${numnodes}*${mpi_tasks_per_node}]
CMD="$application $options"
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
	mv machine.file.$JOBID $write_path/machine.file.$JOBID
fi
echo -e "\nnumtasks=$numtasks, numnodes=$numnodes, mpi_tasks_per_node=$mpi_tasks_per_node (OMP_NUM_THREADS=$OMP_NUM_THREADS)"
echo -e "\nExecuting command:\n==================\n$CMD\n"
eval $CMD 
