#!/bin/bash
#FLUX: --job-name=adorable-butter-8396
#FLUX: -c=32
#FLUX: --urgency=16

export TUNE_MAX_PENDING_TRIALS_PG='32'
export XLA_PYTHON_CLIENT_PREALLOCATE='false'
export OMP_NUM_THREADS='1'

export TUNE_MAX_PENDING_TRIALS_PG=32
export XLA_PYTHON_CLIENT_PREALLOCATE=false
numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel8/default-amp              # REQUIRED - loads the basic environment
module load python-3.9.6-gcc-5.4.0-sbr552h
module load cuda/11.1
module load cudnn/8.0_cuda-11.1
group_name="ASHA_cheap_${dataset}_${optimiser}"
write_path="/rds/user/authorid/hpc-work/LearningSecondOrderOptimiser/tune/${group_name}"
application="source .venv_3.9/bin/activate && python"
options="parallel_exec.py -c configs/${dataset}.yaml configs/${optimiser}.yaml -R ${optimiser} -g tb_ASHA_cheap_${dataset}_${optimiser} --runs_per_gpu ${runs_per_gpu} --time_s ${time_s}"
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
