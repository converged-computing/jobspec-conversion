#!/bin/bash
#
#SBATCH --job-name=leclerce_experiments
#SBATCH --partition=main
#SBATCH --exclusive
#SBATCH --array=11

# Abort whenever a single step fails. Without this, bash will just continue on errors.
#set -e

# Load the required environment modules for OGGM
module load python/3.6.4 oggm-binary-deps/1

# Activate our local OGGM virtualenv
source /home/users/julia/python3_env/bin/activate

# On every node, when slurm starts a job, it will make sure the directory
# /work/username exists and is writable by the jobs user.
# We create a sub-directory there for this job to store its runtime data at.
S_WORKDIR="/work/$SLURM_JOB_USER/leclercq"

mkdir -p "$S_WORKDIR"

echo "Workdir for this run: $S_WORKDIR"

echo "$SLURM_ARRAY_TASK_ID"
I=$SLURM_ARRAY_TASK_ID

# Export the WORKDIR as environment variable so our benchmark script can use it to find its working $
export S_WORKDIR
export I
export OGGM_DOWNLOAD_CACHE="/home/data/download"
export OGGM_DOWNLOAD_CACHE_RO=1
export SLURM_ARRAY_TASK_ID
echo "$SLURM_ARRAY_TASK_ID"

# Run the actual job. The srun invocation starts it as individual step for slurm.
srun -n 1 -c "${SLURM_JOB_CPUS_PER_NODE}" python3 ./run_leclercq.py
# Print a final message so you can actually see it being done in the output log.
echo "DONE"

# Once a slurm job is done, slurm will clean up the /work directory on that node from any leftovers $
# So copy any result data you need from there back to your home dir!
# $SLURM_SUBMIT_DIR points to the directory from where the job was initially commited.


# Copy any neccesary result data.
cp -r "${S_WORKDIR}" "${OUTDIR}"


