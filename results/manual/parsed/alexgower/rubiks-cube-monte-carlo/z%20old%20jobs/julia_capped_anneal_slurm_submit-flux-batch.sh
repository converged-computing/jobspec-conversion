#!/bin/bash
#FLUX: --job-name=fuzzy-citrus-6767
#FLUX: -n=3
#FLUX: -t=43200
#FLUX: --priority=16

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel7/default-ccl              # REQUIRED - loads the basic environment
module load julia/1.7.3
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
cd $workdir
echo -e "Changed directory to `pwd`.\n"
JOBID=$SLURM_JOB_ID
echo -e "JobID: $JOBID\n======"
echo "Time: `date`"
echo "Running on master node: `hostname`"
echo "Current directory: `pwd`"
julia job_capped_anneal.jl
