# Flux batch script equivalent

# Define job name
export FLUX_JOB_NAME="surf.discoal"

# Resource requests
export FLUX_NODES=1
export FLUX_CPUS_PER_TASK=1
export FLUX_MEMORY="120G"
export FLUX_WALLTIME="12:00:00"

# Array job setup
export FLUX_ARRAY_SIZE=23

# Working directory
cd /home/mcgaughs/shared/Software/diploSHIC

# Discoal executable path
discoal="/home/mcgaughs/shared/Software/discoal/discoal"

# Command list file
CMD_LIST="Surface_discoal_commands_w_3popsizes_2.txt"

# Get the command for the current array task
CMD=$(sed "${FLUX_ARRAY_INDEX}q;d" ${CMD_LIST})

# Execute the command
eval ${CMD}