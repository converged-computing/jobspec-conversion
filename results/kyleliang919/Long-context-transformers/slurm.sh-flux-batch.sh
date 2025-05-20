#!/bin/bash
#FLUX: -N 2
#FLUX: --tasks-per-node=8
#FLUX: --cpus-per-task=12
#FLUX: --gpus-per-task=1  # Assuming 1 GPU per task, so 8 GPUs per node
#FLUX: --job-name=testlongcontext
#FLUX: -o gpt_neox_20.out
#FLUX: --exclusive
# The Slurm #SBATCH --partition=g80n140 might map to a Flux queue or a resource constraint.
# e.g., #FLUX: -q my_gpu_queue
# or #FLUX: --requires=type=g80 (if 'g80' is a defined resource feature/type in Flux)

# Load necessary modules
module load openmpi
module load cuda/11.7 # Ensure this CUDA version is compatible with the allocated GPUs

# Set environment variables
export PYTHONFAULTHANDLER=1
export CUDA_LAUNCH_BLOCKING=0 # Original script had 0, which is typical for production runs

# Get node information from Flux
# flux resource list --hosts provides a newline-separated list of unique allocated hostnames
HOSTNAMES_LIST=$(flux resource list --hosts)

# For environment variable HOSTNAMES (space-separated list)
export HOSTNAMES=$(echo "$HOSTNAMES_LIST" | tr '\n' ' ')

# Determine MASTER_ADDR (first node in the allocation)
export MASTER_ADDR=$(echo "$HOSTNAMES_LIST" | head -n 1)

# Set MASTER_PORT (same as in the original script)
export MASTER_PORT=12802

# Determine COUNT_NODE (total number of allocated nodes)
export COUNT_NODE=$(echo "$HOSTNAMES_LIST" | wc -l)

echo "Flux job starting..."
echo "Running on $COUNT_NODE nodes: $HOSTNAMES"
echo "Master Address: $MASTER_ADDR"
echo "Master Port: $MASTER_PORT"

# Create hostfile for deepspeed's OpenMPI launcher
# The original script implies the hostfile is named 'hostfile.txt' and located in
# '/fsx/home-kaizhaol/long-context-transformers/'.
# The 'slots' should correspond to the number of tasks per node.
hostfile_path="/fsx/home-kaizhaol/long-context-transformers/hostfile.txt"
rm -f "$hostfile_pa