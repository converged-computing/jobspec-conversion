# Flux batch script equivalent

# Define job name
export FLUX_JOB_NAME="fvecSim"

# Resource requests
export FLUX_NODES=1
export FLUX_CPUS_PER_TASK=1
export FLUX_MEMORY="60gb"
export FLUX_WALLTIME="3:00:00"

# Array job setup
export FLUX_ARRAY_SIZE=23

# Command to execute for each array task
export FLUX_COMMAND="
cd /home/mcgaughs/shared/Software/diploSHIC
CMD_LIST=\"Surface.fvecSim.commnads.txt\"
CMD=\$(sed \"\$FLUX_ARRAY_INDEX+1q;d\" \$CMD_LIST)
eval \$CMD
"

# Submit the job
flux run