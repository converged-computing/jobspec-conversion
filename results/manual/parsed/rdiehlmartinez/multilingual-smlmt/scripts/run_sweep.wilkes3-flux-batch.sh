#!/bin/bash
#FLUX: --job-name=lovely-leopard-6569
#FLUX: -t=42600
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel8/default-amp              # REQUIRED - loads the basic environment
JOBID=$SLURM_JOB_ID
export OMP_NUM_THREADS=1
np=$[${numnodes}*${mpi_tasks_per_node}]
echo -e "Changed directory to `pwd`.\n"
echo -e "JobID: $JOBID\n======"
echo "Time: `date`"
echo "Running on master node: `hostname`"
echo "Current directory: `pwd`"
echo -e "\nnumtasks=$numtasks, numnodes=$numnodes, mpi_tasks_per_node=$mpi_tasks_per_node (OMP_NUM_THREADS=$OMP_NUM_THREADS)"
cd ..
source env/bin/activate
if [[ $# -eq 1 ]]
then
  echo "Starting new sweep agent with ID: $1"
  echo "Generating new run with ID: $JOBID"
  sweepid=$1
  export RUN_ID=$JOBID
  timeout -s SIGINT --kill-after=50m 11h wandb agent --count 1 $sweepid 
elif [[ $# -eq 2 ]]
then
  # NOTE: we don't actually use the sweepid here, we pass it in to indicate that we 
  # are resuming a sweep agent
  echo "Resuming sweep agent with ID: $1; run ID: $2"
  sweepid=$1
  RUN_ID=$2
  timeout -s SIGINT --kill-after=50m 11h python run_model.py --run_id $2
else
  echo "Invalid number of arguments (should either be 1 or 2)"
  exit 1
fi
if [[ $? -eq 124 ]]; then
  cd scripts
  sbatch run_sweep.wilkes3 $sweepid $RUN_ID
fi
