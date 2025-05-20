#!/bin/bash
#FLUX: -J gps_paper_pipeline_scheduler
#FLUX: -N 1
#FLUX: -n 1
#FLUX: -c 4
#FLUX: -t 6:00:00
#FLUX: --mail-type=FAIL 
# Note: Flux might require --mail-user=your_email@example.com
#FLUX: --queue=cclake
#FLUX: -o logs/gps_paper_pipeline_scheduler/%J.out
# The -A (account) directive from Slurm (MRC-BSU-SL2-CPU) does not have a direct #FLUX: equivalent.
# Account/project association is typically handled by queue configurations or site-specific flux submit options.

#! Number of nodes and tasks per node allocated by Flux (do not change):
# FLUX_JOB_NUM_NODES and FLUX_JOB_SIZE (equivalent to ntasks) are typically available.
# If not, they can be queried. For this script, we'll assume they are set.
numnodes=${FLUX_JOB_NUM_NODES:-$(flux job info --format=json | jq .spec.resources[0].count)} # Fallback if FLUX_JOB_NUM_NODES not set
numtasks=${FLUX_JOB_SIZE:-$(flux job info --format=json | jq .ntasks)} # Fallback if FLUX_JOB_SIZE not set

# Calculate mpi_tasks_per_node. For -N 1 -n 1, this will be 1.
if [ -n "$numnodes" ] && [ "$numnodes" -ne 0 ]; then
    mpi_tasks_per_node=$((numtasks / numnodes))
else
    mpi_tasks_per_node=$numtasks # Or handle error if numnodes is 0 or undefined
fi


#! Optionally modify the environment seen by the application
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel7/default-peta4            # REQUIRED - loads the basic environment

# FLUX_SUBMIT_DIR is the directory where flux submit was run.
# Flux jobs typically start in this directory by default.
workdir="${FLUX_SUBMIT_DIR:-$(pwd)}" # Use FLUX_SUBMIT_DIR or current dir as fallback

#! Are you using OpenMP (NB this is unrelated to OpenMPI)? If so increase this
#! safe value. Original script set to 5 with 4 cpus-per-task.
export OMP_NUM_THREADS=5

#! Number of MPI tasks to be started by the application per node and in total (do not change):
# np represents total number of MPI tasks if this were an MPI job.
# For this job (-n 1), np will be 1.
np=$((numnodes * mpi_tasks_per_node))


#! The following variables define a sensible pinning strategy for Intel MPI tasks -
#! this should be suitable for both pure MPI and hybrid MPI/OpenMP jobs:
export I_MPI_PIN_DOMAIN=omp:compact # Domains are $OMP_NUM_THREADS cores in size
export I_MPI_PIN_ORDER=scatter # Adjacent domains have minimal sharing of caches/sockets

###############################################################
### You should not have to change anything below this line ####
###############################################################

cd "$workdir"
echo -e "Changed directory to `pwd`.\n"

JOBID=$FLUX_JOB_ID

echo -e "JobID: $JOBID\n======"
echo "Time: `date`"
echo "Running on mcadr node: `hostname`" # In Flux, this will be the lead broker or a compute node.
echo "Current directory: `pwd`"

# In Flux, flux resource list can provide node information.
# Create a machine file:
mkdir -p logs # Ensure logs directory exists
# Get unique hostnames, one per line, without headers
flux R list --hosts -H > "logs/machine.file.$JOBID"
if [ -s "logs/machine.file.$JOBID" ]; then
    echo -e "\nNodes allocated:\n================"
    # The sed command strips domain names, e.g., node1.cluster -> node1
    cat "logs/machine.file.$JOBID" | sed -e 's/\..*$//g'
fi

echo -e "\nnumtasks=$numtasks, numnodes=$numnodes, mpi_tasks_per_node=$mpi_tasks_per_node (OMP_NUM_THREADS=$OMP_NUM_THREADS)"

echo -e "\nExecuting command:\n==================\n\n"

# Conda setup - preserved from original script
__conda_setup="$('/rds/project/rds-csoP2nj6Y6Y/tw395/mambaforge/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/rds/project/rds-csoP2nj6Y6Y/tw395/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/rds/project/rds-csoP2nj6Y6Y/tw395/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/rds/project/rds-csoP2nj6Y6Y/tw395/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

unset R_LIBS

conda activate snakemake_env

# Execute the main application
# "${@}" passes any arguments from the `flux submit` command line to snakemake
snakemake --profile profile "${@}"