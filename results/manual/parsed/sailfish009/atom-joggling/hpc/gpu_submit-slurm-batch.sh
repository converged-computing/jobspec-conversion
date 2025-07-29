#!/bin/bash
#SBATCH --account=LEE-JR769-SL2-GPU
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=pascal

. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel7/default-gpu              # REQUIRED - loads the basic environment
cd $SLURM_SUBMIT_DIR
echo -e "Job ID: $SLURM_JOB_ID\nJob name: $SLURM_JOB_NAME\n"
echo "Time: `date`"
echo "Running on master node: `hostname`"
echo "Current directory: `pwd`"
echo -e "\nNodes allocated: num_tasks=$SLURM_NTASKS, num_nodes=$SLURM_JOB_NUM_NODES"
echo -e "\nExecuting command:\n$CMD\n\n==================\n"
eval $CMD
