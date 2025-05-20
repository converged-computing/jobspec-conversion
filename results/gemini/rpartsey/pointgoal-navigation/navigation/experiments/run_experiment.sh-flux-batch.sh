#!/bin/bash
#FLUX: -N 8
#FLUX: --ntasks-per-node=8
#FLUX: -c 10
#FLUX: --gpus-per-node=8
#FLUX: --mem-per-node=450GB
#FLUX: -t 72h # 72:00:00
#FLUX: -J ddppo-object-nav
#FLUX: --queue=prioritylab
# Note: Flux does not have a direct equivalent for Slurm's --constraint.
# The 'volta32gb' constraint would typically be handled by requesting a specific GPU resource type
# if configured in Flux (e.g., gres=gpu{type=volta32gb}:8) or by the properties of the 'prioritylab' queue.
# For this translation, we assume the queue or gres=gpu:8 implies the correct GPU type.

#FLUX: --signal=USR1@600s # Send USR1 600 seconds before walltime expiry
# Note: Flux does not have built-in mail notification options like Slurm's --mail-user/--mail-type.
# This would need to be handled by external mechanisms if required.
# Note: Flux's default output/error handling is typically append. --open-mode=append is implicit.
# FLUX: --job-option=comment="CVPR 2021" # Flux way to add a comment, if supported as a generic option

# In Flux, the batch script itself typically runs on rank 0 of the allocation.
# The original script uses `srun --ntasks=1 hostname` to get a master address.
# A similar approach in Flux, running a utility task:
export MASTER_ADDR=$(flux exec -n 1 --quiet hostname)
# Alternatively, if the application uses MPI and discovers rank 0, or if this script runs on rank 0:
# export MASTER_ADDR=$(hostname)

# avoid error: semaphore_tracker: There appear to be 1 leaked semaphores to clean up at shutdown
export PYTHONWARNINGS='ignore:semaphore_tracker:UserWarning'

EXP_NAME="obj_nav_mp3d_1_ep_slack-1e3"

# Sourcing user and system profiles
# These are kept as in the original script, but ensure they are appropriate for the Flux environment
source ~/.bash_profile
source ~/.profile
source /etc/bash.bashrc
source /etc/profile

export GLOG_minloglevel=2
export MAGNUM_LOG=quiet

# Module loading commands remain the same
module unload cuda
module load cuda/10.1
module unload cudnn
module load cudnn/v7.6.5.32-cuda.10.1
module load anaconda3/5.0.1
module load gcc/7.1.0
module load cmake/3.10.1/gcc.5.4.0
source activate challenge_2021

export CUDA_HOME="/public/apps/cuda/10.1"
export CUDA_NVCC_EXECUTABLE="/public/apps/cuda/10.1/bin/nvcc"
export CUDNN_INCLUDE_PATH="/public/apps/cuda/10.1/include/"
export CUDNN_LIBRARY_PATH="/public/apps/cuda/10.1/lib64/"
export LIBRARY_PATH="/public/apps/cuda/10.1/lib64"
export CMAKE_PREFIX_PATH=${CONDA_PREFIX:-"$(dirname $(which conda))/../"}
export USE_CUDA=1 USE_CUDNN=1 USE_MKLDNN=1

CURRENT_DATETIME="`date +%Y_%m_%d_%H_%M_%S`";
echo "CUDA_VISIBLE_DEVICES: $CUDA_VISIBLE_DEVICES" # Original script echoed this, good for debugging
unset LD_PRELOAD

# CMD_OPTS_FILE must be set in the environment or defined here
if [ -z "$CMD_OPTS_FILE" ]; then
  echo "Error: CMD_OPTS_FILE environment variable is not set." >&2
  exit 1
fi
CMD_OPTS=$(cat "$CMD_OPTS_FILE")

set -x

# The total number of tasks is N_nodes * ntasks_per_node = 8 * 8 = 64.
# flux exec will launch the command across the allocated resources.
# The resource specifications (-N, --ntasks-per-node, -c, --gpus-per-node)
# provided to Flux at the job level will define the environment for flux exec.
flux exec python -u run_ddppo.py \
    --run-type train ${CMD_OPTS}

# Original commented out command:
# flux exec python -u -m habitat_baselines.run \
#    --exp-config config_files/ddppo/ddppo_pointnav_2021.yaml \
#    --run-type train ${CMD_OPTS}
```