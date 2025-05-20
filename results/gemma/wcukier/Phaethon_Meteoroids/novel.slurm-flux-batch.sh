# Flux batch script equivalent

# Job name
export FLUX_JOB_NAME=novel

# Resources
export FLUX_NODES=1
export FLUX_CORES=1
export FLUX_MEMORY="300M"  # Flux handles memory per core/task differently, this is a starting point.  May need adjustment.
export FLUX_WALLTIME="03:02:00"

# Email (Flux doesn't directly support email notifications like Slurm)
# You'd need to implement this separately, e.g., with a script that checks job status.

# Output/Error (Flux uses stdout/stderr redirection)
export FLUX_OUTPUT_REDIRECT="logs/R-%t.%j.out"
export FLUX_ERROR_REDIRECT="logs/R-%t.%j.err"

# Array job
export FLUX_ARRAY_SIZE=100

# Software
module purge
module load anaconda3/2021.5

# Command to run
# Flux uses $FLUX_ARRAY_TASK_ID for array task ID
python main.py $FLUX_ARRAY_TASK_ID 0 100 2000