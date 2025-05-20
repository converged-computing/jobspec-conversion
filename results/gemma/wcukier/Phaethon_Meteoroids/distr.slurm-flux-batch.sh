# Flux batch script equivalent

# Define job name
export FLUX_JOB_NAME="distr"

# Resource requests
export FLUX_NODES=1
export FLUX_CORES=1
export FLUX_MEMORY="1000M"  # Total memory, not per CPU
export FLUX_WALLTIME="03:59:00"

# Email notifications (Flux doesn't directly support this, needs external setup)
# Consider using a separate notification system.

# Output and error redirection
export FLUX_OUTPUT_DIR="logs"
export FLUX_OUTPUT_PREFIX="R"
export FLUX_OUTPUT_SUFFIX=".out"
export FLUX_ERROR_DIR="logs"
export FLUX_ERROR_PREFIX="R"
export FLUX_ERROR_SUFFIX=".err"

# Array job
export FLUX_ARRAY_SIZE=1000

# Software modules
module purge
module load anaconda3/2021.5

# Command to execute
# Flux uses $FLUX_TASK_ID for array task ID
python main.py $FLUX_TASK_ID 2 100 2000