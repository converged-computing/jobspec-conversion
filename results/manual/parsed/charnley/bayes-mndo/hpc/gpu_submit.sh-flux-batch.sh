#!/bin/bash
#FLUX: --job-name=creamy-nalgas-2869
#FLUX: -t=36000
#FLUX: --urgency=16

. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel7/default-gpu              # REQUIRED - loads the basic environment
application="python"
options="src/scipy_optim"
CMD="$application $options"
cd $SLURM_SUBMIT_DIR
echo -e "JobID: $SLURM_JOB_ID\n"
echo "Time: `date`"
echo "Running on master node: `hostname`"
echo "Current directory: `pwd`"
echo -e "\nNodes allocated: numtasks=$numtasks, numnodes=$numnodes"
echo -e "\nExecuting command: $CMD\n\n=================="
eval $CMD
